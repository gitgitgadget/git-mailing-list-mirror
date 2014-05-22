From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete
 for refs we know are packed only
Date: Thu, 22 May 2014 16:53:51 -0700
Message-ID: <20140522235351.GB12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-42-git-send-email-sahlberg@google.com>
 <20140522181722.GT12314@google.com>
 <CAL=YDWkUa2Ut=1iaMXgnjgte6g5jvXR49LBiEUNEkwv4Z-wO_w@mail.gmail.com>
 <CAL=YDW=hytDiz5qzAMyBgXUgza+AcDhk_y3m3kAUmOdBG=F=vA@mail.gmail.com>
 <20140522234440.GA12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 23 01:54:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WncoA-0004A4-GF
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 01:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbaEVXxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 19:53:55 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:60442 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbaEVXxy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 19:53:54 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so3239409pbc.29
        for <git@vger.kernel.org>; Thu, 22 May 2014 16:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZDbPz/H7AGPB17Iv4gac+hiOdd3BYqhCSTu8gzZnpxg=;
        b=NB1G2oIuh8giuZm83necDG1DPAkj9B1XyDFojRsK6zhji3BIdGm0c5jkMjCpz3Y3+r
         Acm5D28la6sZoOoNtLStnm/RB6MOeGsexNKOtpNCj5AAakSuGBuxWHyUWCv90bTaKuHJ
         L98NepXWWwvfn426Tj3AEQ8UTvMnIYjvYAYKE3L3glEeLw81hN0L+8+0O+XdF4Dejegr
         rcienB/iU7UjzOw8paG6CZC0ZtYKvVUaYPCcJBK9MFIgfvKIyQX+xfMB1ohHLo5WqYAe
         5XnRHv/V6T0mYbO8ETHnnDiUp00AwIUdJ70f/u5ttKSolfShhfG048zZcA0odm9MCFxJ
         oNBw==
X-Received: by 10.68.241.68 with SMTP id wg4mr1300736pbc.66.1400802833764;
        Thu, 22 May 2014 16:53:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xc1sm5401850pab.39.2014.05.22.16.53.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 16:53:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140522234440.GA12314@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249966>

Jonathan Nieder wrote:
> Ronnie Sahlberg wrote:

>> I hate rename_ref :-)
>>
>> I have reworked the transaction code to special case the deletion of
>> the old ref for n/n -> n  and n -> n/n renames
>> so that we can carefully avoid n/n.lock files to exist or prevent the
>> directory <-> file transition for n during these renames.
[...]
> 	Unlink the corresponding loose refs so packed-refs
> 		becomes authoritative for them.
> 	Lock packed-refs.
> 	Perform updates and removals in the packed-refs cache.
> 	Commit packed-refs.

... or is the problem that the reflogs conflict?

How does rename_ref handle propagating the reflog from the old
name to the new name, by the way?

Thanks,
Jonathan
