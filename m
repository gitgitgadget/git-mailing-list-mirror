From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 13:05:12 -0700
Message-ID: <20130410200512.GB27070@google.com>
References: <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
 <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:05:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1Gn-0000AB-4W
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801Ab3DJUFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:05:18 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:44309 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3DJUFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:05:17 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so498022pab.32
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 13:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MXtL2IwZ4ONLhAszhliodx0O8ES2osdMgDhf0OHMfKc=;
        b=SWIsbX0aK6ZZcUYfAFnLd0gpf/WcFDOc9Rw8EIvIi3wJA0KFIxpBDrtw/EOa+M6phg
         reoqx6wpbvNl+X5vgLXE421uOV7Qb9iR1RiV+9wayeVFyDPCyPRm0HRDB2FNR6WqXUVH
         yUIl4MoA+KABVOYF85NSnHpO0xen6s7AeXUCnKqPaKPzsNgIhJzvMDW8EAb+Fo4GI6mC
         nj/OF61NE1aIaAl4AY4p9NHDEJh5kJL/o5sGjpm6YAfqRucGtfGQPHLbJvKo1Vfaz61d
         iU1uoW7qS4r59QJTNvzCY+MrAuhKckMaCfFI6pSOXqDFiUea6FYipCbLGfobGm1SKmWa
         PeFg==
X-Received: by 10.66.122.39 with SMTP id lp7mr5537462pab.116.1365624316754;
        Wed, 10 Apr 2013 13:05:16 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id z8sm1100852pbt.23.2013.04.10.13.05.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 13:05:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220744>

Ramkumar Ramachandra wrote:
> Ramkumar Ramachandra wrote:

>> git push -- master next; pushes to my current branch's
>> branch.<name>.pushremote?  Isn't that a disaster?
>
> Actually, branch.<name>.pushremote already breaks the current design
> in a way

I don't see a big problem here, actually.  What's so wrong with
branch.<name>.remote affecting what "git push" does?  If
branch.crazy-feature.remote is my-personal-remote and I run

	git push

and "[push] default = upstream", then it is obvious what the user
wanted to happen.  But what about when "[push] default = matching"?
Which of the following behaviors is correct?

 a) Error: you didn't tell me which remote to push to.
 b) Just behave like "git push my-personal-remote :".
 c) Ignore which branch is the current branch and behave like
    "git push origin :".

How about when "[push] default = current"?

Except that people might have scripts or habits tied to the current
behavior, any of (a), (b), and (c) sounds fine to me.  (b) is the
obvious choice for historical reasons.

Now if I rely on the proposed DWIM and run

	git push master

then the corresponding choices are:

 a) Error: you didn't tell me which remote to push to.
 b) Just behave like "git push my-personal-remote master".
 c) Behave like "git push origin master".
 
(b) is not a good choice there, but (a) and (c) look equally fine.
