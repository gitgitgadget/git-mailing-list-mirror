From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH v2 3/3] t9903: add extra tests for bash.showDirtyState
Date: Wed, 13 Feb 2013 18:37:45 +0100
Message-ID: <1360777065.13768.17.camel@mas>
References: <1360753138.25490.10.camel@mas>
	 <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
	 <1360753321-5002-3-git-send-email-martinerikwerner@gmail.com>
	 <7vy5es9o0g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trsten@science-computing.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 18:38:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5gHd-0003K6-KU
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 18:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934536Ab3BMRhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 12:37:50 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:39741 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934504Ab3BMRht (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 12:37:49 -0500
Received: by mail-la0-f43.google.com with SMTP id ek20so1445230lab.16
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 09:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:x-mailer:mime-version
         :content-transfer-encoding;
        bh=yUhog4TCl2PsOn2pdnjFFeeEca7rjw4C+U4Ozx+TJgY=;
        b=ZfmTdVOk20yhs+VFkMzRaPt19/k0xyZz58lrveTPmO3eiKWyS5piwXTFmmvIFxUHcp
         XaXphRfQTrcwYozDKUp18q8AZvYmlscAp/ZvVdjS1epJcZdYHinOWcBmZjwaESmhzixM
         AqIfKkCs6Q/F+s/bWeHa9SuNJ+ysLs1Zs4d/V5Ox/UHavKSCZYeRLcfSDQnmyLZlKkgL
         YS8ZN6Tg11b80D3lcC3myMq3IcOlatdqYcjOvY10Y2O1hUJdyMI2iFNmOo1RIfmUxVPN
         J7wYGwDQQh89XCjI+I763l5pWaqExj8sa/OjDL0YldjscsRicFP9A3VmW+/VOmepdmfg
         Pegg==
X-Received: by 10.152.46.131 with SMTP id v3mr18331378lam.57.1360777068251;
        Wed, 13 Feb 2013 09:37:48 -0800 (PST)
Received: from [192.168.1.2] (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id l1sm916373lbn.8.2013.02.13.09.37.46
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 09:37:47 -0800 (PST)
In-Reply-To: <7vy5es9o0g.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216274>

On Wed, 2013-02-13 at 08:28 -0800, Junio C Hamano wrote:
> Martin Erik Werner <martinerikwerner@gmail.com> writes:
> 
> > Added 3 extra tests for the bash.showDirtyState config option, tests
> > should now cover all combinations of the shell var being set/unset and
> > the config option being enabled/disabled, given a dirty file.
> 
> Strictly speaking, you have 6 not 4 combinations (shell variable
> set/unset * config missing/set to false/set to true).  I think these
> additional tests cover should all 6 because "config missing" case
> should already have had tests before bash.showDirtyState was added.
> 

Indeed, I only mentioned 4 since the other ones existed already, and I
didn't change them, but maybe it should be mentioned as "combined with
previous tests (...) cover all 6 combinations (...)" then?

> > * Renamed test 'disabled by config' to 'shell variable set with config
> >   disabled' for consistency
> > ---
> 
> Sign-off?

Ah, just forgot the -s flag on that commit, yes it should be Signed-off
by me.

> 
> >  t/t9903-bash-prompt.sh |   38 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> > index cb008e2..fa81b09 100755
> > --- a/t/t9903-bash-prompt.sh
> > +++ b/t/t9903-bash-prompt.sh
> > @@ -360,12 +360,48 @@ test_expect_success 'prompt - dirty status indicator - before root commit' '
> >  	test_cmp expected "$actual"
> >  '
> >  
> > -test_expect_success 'prompt - dirty status indicator - disabled by config' '
> > +test_expect_success 'prompt - dirty status indicator - shell variable unset with config disabled' '
> >  	printf " (master)" > expected &&
> >  	echo "dirty" > file &&
> >  	test_when_finished "git reset --hard" &&
> >  	test_config bash.showDirtyState false &&
> >  	(
> > +		unset -v GIT_PS1_SHOWDIRTYSTATE &&
> > +		__git_ps1 > "$actual"
> > +	) &&
> > +	test_cmp expected "$actual"
> > +'
> > +
> > +test_expect_success 'prompt - dirty status indicator - shell variable unset with config enabled' '
> > +	printf " (master)" > expected &&
> > +	echo "dirty" > file &&
> > +	test_when_finished "git reset --hard" &&
> > +	test_config bash.showDirtyState true &&
> > +	(
> > +		unset -v GIT_PS1_SHOWDIRTYSTATE &&
> > +		__git_ps1 > "$actual"
> > +	) &&
> > +	test_cmp expected "$actual"
> > +'
> > +
> > +test_expect_success 'prompt - dirty status indicator - shell variable set with config disabled' '
> > +	printf " (master)" > expected &&
> > +	echo "dirty" > file &&
> > +	test_when_finished "git reset --hard" &&
> > +	test_config bash.showDirtyState false &&
> > +	(
> > +		GIT_PS1_SHOWDIRTYSTATE=y &&
> > +		__git_ps1 > "$actual"
> > +	) &&
> > +	test_cmp expected "$actual"
> > +'
> > +
> > +test_expect_success 'prompt - dirty status indicator - shell variable set with config enabled' '
> > +	printf " (master *)" > expected &&
> > +	echo "dirty" > file &&
> > +	test_when_finished "git reset --hard" &&
> > +	test_config bash.showDirtyState true &&
> > +	(
> >  		GIT_PS1_SHOWDIRTYSTATE=y &&
> >  		__git_ps1 > "$actual"
> >  	) &&
