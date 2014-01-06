From: Bryan Turner <bturner@atlassian.com>
Subject: Re: Re: [Bug report] 'git status' always says "Your branch is
 up-to-date with 'origin/master'"
Date: Mon, 6 Jan 2014 01:48:49 -0700
Message-ID: <CAGyf7-FX1sPjwvKdxeEXopffFPiftgDRqoe7NRWyM1Cm=5n6Sw@mail.gmail.com>
References: <1963290835.719443.1388996669450.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: worldhello.net@gmail.com, Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Jan 06 09:55:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W05yF-0004nB-TD
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 09:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbaAFIzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 03:55:35 -0500
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:46396 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751799AbaAFIze (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 03:55:34 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jan 2014 03:55:34 EST
Received: from mail-ob0-f176.google.com ([209.85.214.176]) (using TLSv1) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUspvhpCH2/Gg8KrqUYVJs9u9XISmKJVq@postini.com; Mon, 06 Jan 2014 00:55:34 PST
Received: by mail-ob0-f176.google.com with SMTP id vb8so17955593obc.21
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 00:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=iEbDcwNHEjMidLU9o+3TtUOqBHzWqwRdMZ//ty2/cMk=;
        b=Y+j2uL7kX3FBulQUdVaLjL9UAEFg85ETjXKRlCHpeouXsMuIsuhYsyyjYqM1tAEaSS
         vkxl9c57W7oJ0moEx6vd8NkvPNcReYpbwHy/qIQgvqK1QVbNVx46HYRtMp3Cb6QcDiYu
         50EWUGPisYsjJ+uLWkmHK2iFfJShjxHiRjewfGhktBOefhIkDP4KBM9GirXbfGmkxZ75
         4sweylpDIlRxRTJbriDhjifPMmlI9bbgGDTYCfeRBz7FXuZWjyAarRSnhpHUhAZeAPDC
         uHbpjooQfbjISKnoeTdcjpf3zMJwKsLMM3EcCUGO/tIcbrn/IQ/rOSU4nR3OPLwbiioP
         JA2Q==
X-Received: by 10.60.233.9 with SMTP id ts9mr29082oec.65.1388998130078;
        Mon, 06 Jan 2014 00:48:50 -0800 (PST)
X-Gm-Message-State: ALoCoQk11QQnXGkS9aPMaSt/u1+pombCOLgmimNleF2ZPRpTwl7ylEXxZP8n6rev9acIFPYQC4lXpypGXc6rmWXkLz9vjBvPPSdvhl6KEgx9QfLlhRel3f4OUcG59ea6OkhC7PFe2eKYPdNUPoaSnR6khDtc16w2+Q==
X-Received: by 10.60.233.9 with SMTP id ts9mr29073oec.65.1388998129987; Mon,
 06 Jan 2014 00:48:49 -0800 (PST)
Received: by 10.182.126.226 with HTTP; Mon, 6 Jan 2014 00:48:49 -0800 (PST)
In-Reply-To: <1963290835.719443.1388996669450.JavaMail.ngmail@webmail15.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239989>

On 6 January 2014 01:24, Thomas Ackermann <th.acker@arcor.de> wrote:
>
>
> Hi Jiang,
>
> this happens with all of my repo clones (I am using V1.8.5.2
> on Windows and on Linux). Steps to reproduce:
>
> mkdir repo_a && cd repo_a && git init .
> echo "1">foo && git add foo && git commit -m "1"
> cd ..
> git clone repo_a repo_b
> cd repo_a
> echo "2">foo && git add foo && git commit -m "2"
> cd ../repo_b
> git status
> git checkout -b "branch"
> git checkout master
>
> 'git status' and 'git checkout master' in repo_b are now
> reporting "Your branch is up-to-date with 'origin/master'"
> which is obviously wrong.
>

Unfortunately that's not true. In repo_b your ref for origin/master
has not moved. It has remotely (meaning refs/heads/master in repo_a
has moved), but git status is not hitting the remote to find out; it
only looks at the local state. To see what I mean, run git fetch in
repo_b. Once you do that, you'll see that git status correctly reports
you're behind.

>
> ---
> Thomas
>
> ----- Original Nachricht ----
> Von:     Jiang Xin <worldhello.net@gmail.com>
> An:      Thomas Ackermann <th.acker@arcor.de>
> Datum:   06.01.2014 06:31
> Betreff: Re: [Bug report] 'git status' always says "Your branch is up-to-date
>  with 'origin/master'"
>
> > 2014/1/5 Thomas Ackermann <th.acker@arcor.de>:
> > > Since f223459 "status: always show tracking branch even no change"
> > > 'git status' (and 'git checkout master' always says
> > > "Your branch is up-to-date with 'origin/master'"
> > > even if 'origin/master' is way ahead from local 'master'.
> >
> > Hi, Thomas
> >
> > Can you provide your operations so that I can reproduce this issue?
> >
> > In the commit you mentioned above, there was a new test case named
> > 'checkout (up-to-date with upstream)' added in 't6040'. I also add two
> > test-cases locally in order to reproduce the issue you report, and run
> > them in arbitrary orders, but they all look fine:
> >
> >     ok 4 - checkout (behind upstream)
> >     ok 5 - checkout (ahead upstream)
> >     ok 6 - checkout (diverged from upstream)
> >     ok 7 - checkout with local tracked branch
> >     ok 8 - checkout (upstream is gone)
> >     ok 9 - checkout (up-to-date with upstream)
> >     ok 10 - checkout (upstream is gone)
> >     ok 11 - checkout with local tracked branch
> >     ok 12 - checkout (diverged from upstream)
> >     ok 13 - checkout (ahead upstream)
> >     ok 14 - checkout (behind upstream)
> >     ok 15 - checkout (diverged from upstream)
> >     ok 16 - checkout (upstream is gone)
> >     ok 17 - checkout (ahead upstream)
> >     ok 18 - checkout with local tracked branch
> >     ok 19 - checkout (behind upstream)
> >
> >
> > The two additional test cases I used locally are:
> >
> >     checkout_test1() {
> >     test_expect_success 'checkout (behind upstream)' '
> >             (
> >                     cd test && git checkout b3
> >             ) >actual &&
> >             test_i18ngrep "is behind .* by 1 commit, and can be
> > fast-forwarded" actual
> >     '
> >     }
> >
> >     checkout_test_2() {
> >     test_expect_success 'checkout (ahead upstream)' '
> >             (
> >                     cd test && git checkout b4
> >             ) >actual &&
> >             test_i18ngrep "is ahead of .* by 2 commits" actual
> >     '
> >     }
> >
> > --
> > Jiang Xin
> >
>
> ---
> Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
