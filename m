From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH 3/3] git submodule update should give notice when run
 without init beforehand
Date: Thu, 19 Sep 2013 22:25:27 +1200
Message-ID: <523AD117.20109@gmail.com>
References: <1379266703-29808-1-git-send-email-rctay89@gmail.com> <1379266703-29808-2-git-send-email-rctay89@gmail.com> <1379266703-29808-3-git-send-email-rctay89@gmail.com> <CALUzUxrf+ZGX8nQ0DVqYEyWto3Cos16VLTUfjsX99qnDLa=S6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 12:24:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMbPP-0004jm-4a
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 12:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824Ab3ISKYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 06:24:23 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:38503 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab3ISKYW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 06:24:22 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so8159425pde.23
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 03:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0qObNIstoyYI+pajKQfAxSiL8ExMB/KMyWE1LX9KTKc=;
        b=QpBwOOSn8gCNvUz+6hkBErubM81VzcQK97zHVRpaVPay4W6NPB7viKV5YyOYWM9zT3
         +LdnVVnN4zkuE5YwCESwiZiFPVTGvemJNkOiigYEJor22bPX0ySnpFcMRQFDF7ku6lNW
         kPyrFna5jhMv01N9TvDmvoMAOg74q+ILmI3PHQWIL9sOe1WAA9tVBkEJ08xOTFxKPv0C
         cfhZ3gnoHnAu6enly++aH1+rlp6QJEagkqxN30NDQPhG6XWfq4mQPcucDAj5lo03P6Q4
         BPvlOiXVaJjsUu7CqGQZGSH/eiV++v8bWvcLCV28pviMSswd0pnj2XHZlIb0vdNT5YJg
         xLeA==
X-Received: by 10.67.23.199 with SMTP id ic7mr1774023pad.73.1379586262033;
        Thu, 19 Sep 2013 03:24:22 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id ta10sm11165894pab.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 03:24:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CALUzUxrf+ZGX8nQ0DVqYEyWto3Cos16VLTUfjsX99qnDLa=S6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235012>

On 18/09/13 22:22, Tay Ray Chuan wrote:
> Hi Chris,
> 
> I think you mentioned usability issues with git-submodule before on
> the git mailing list, so I thought you might be interested in taking a
> look at this patch. It's attached below, you can also view it at
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/1379266703-29808-3-git-send-email-rctay89@gmail.com
> 
> I would be interested in hearing what you think.
> 

The case I had was that an un-init'd submodule was still a directory on
the file system so 'cd submodule' would work and it could go unnoticed
that we hadn't entered the submodule.

Your change might have helped somewhat but the bigger problem was that
the work-tree representation of an un-init'd submodule is a directory.
There was never any thought to actually run 'git submodule update'
because the developer in question thought they already had.

I think Jens' autoinit may be the right direction. It certainly would be
what we'd want for our use-case at $dayjob.
