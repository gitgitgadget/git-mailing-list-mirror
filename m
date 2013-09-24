From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 24 Sep 2013 15:08:49 -0700
Message-ID: <20130924220849.GS9464@google.com>
References: <20130917203807.GA22059@redhat.com>
 <20130917205615.GA20178@sigill.intra.peff.net>
 <20130919213226.GA21291@redhat.com>
 <20130923210915.GA11202@redhat.com>
 <20130923213729.GE9464@google.com>
 <20130924055419.GA11208@redhat.com>
 <20130924193610.GO9464@google.com>
 <20130924201515.GB23319@redhat.com>
 <20130924213116.GQ9464@google.com>
 <20130924215721.GA2072@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 00:08:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOamv-0007lq-QJ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 00:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab3IXWIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 18:08:54 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:49854 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab3IXWIx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 18:08:53 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so5613350pab.1
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 15:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=52pwEH+azl5vf5VO4z4FD14FBXPog/zkHxBUAwsamIo=;
        b=T+HLNJZonB5VUnlC0RqelUiy24Xz9rJ0DdY1jdirto+oeLb5KlTARHWWu3o9CVog9I
         Bn/+tvHxSnBMFi7lCUd2SEkjFnHoFY1TXMSBzmnWhsaNTEjxdfQKsxUvNkbevsHTXs5/
         99CTyY51C9rm4KBQjQkyEj3Oxnrfm2Ks3irQsnz3QX5aaoIDaxqK1DzXFxxiPUEBv9hH
         vVf537knJfwisriq8MdRMSISMoRSrKLU0z2YnH+2mlx2ja4WJGNFvGxUpNxpC7ls/Mb0
         os+hIHwtx0z2sPqs8FCXf4E4IUlNzweTQOmFf0ZDmCqlBNjtJh+4LuhbQS86DUmbCxL6
         Oa1Q==
X-Received: by 10.66.25.70 with SMTP id a6mr30028759pag.68.1380060533192;
        Tue, 24 Sep 2013 15:08:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id fa4sm48246271pab.17.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 15:08:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130924215721.GA2072@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235321>

Michael S. Tsirkin wrote:
> On Tue, Sep 24, 2013 at 02:31:16PM -0700, Jonathan Nieder wrote:
>> Michael S. Tsirkin wrote:

>>> Just making sure: is it correct that there's no requirement to use same
>>> algorithm between patch-ids.c and builtin/patch-id.c ?
>>
>> I think so,
[...]
>> (They already differ in handling of binary files.)
>
> How do they differ btw?

"git diff" without --binary writes "Binary files a/foo and b/foo
differ" and there is nothing for 'git patch-id' to consume for that
file.  With --binary, "git diff" produces entries in 'GIT binary
patch' format which patch-id also skips.

'git cherry' and friends hash in the old and new versions of a binary
file to avoid accidentally dropping changes (see v1.5.3-rc6~9 "Take
binary diffs into accounts for 'git rebase', 2007-08-18, and
v1.7.3-rc0~27^2 "hash binary sha1 into patch id", 2010-08-15).

Jonathan
