From: Stefan Beller <sbeller@google.com>
Subject: Re: Easy Non-Fast-Forward Pushes
Date: Fri, 27 Feb 2015 09:40:46 -0800
Message-ID: <CAGZ79kZ3_ohE6ebY5MvOk6+QfChppR_OtcmVaw5LBoutTWm3ZA@mail.gmail.com>
References: <loom.20150227T170215-199@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Lasse Kliemann <lasse@lassekliemann.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 18:40:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YROuB-00028A-S4
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 18:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168AbbB0Rks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 12:40:48 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:40604 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110AbbB0Rkr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 12:40:47 -0500
Received: by igal13 with SMTP id l13so2236785iga.5
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 09:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3MMoYjsJFI5q1wkubdZuY9h3t2X13d1eeSt6VNJO7nc=;
        b=XCjxbbCLnAZh1YTZFsn2sLBYZl9sRuTSLaHF0MA0wmkZiBBHwZbdSAx1wWoZaVHK83
         a8gxM+eJN/GveXt0iM8jVU4HHa2KK5o7wLwSly+pL6GjK/6xedpylElTiY2e80t6H0eh
         pOjUnC4VHP1+foPaLCBBeCnvfuccAjrf+oteefrJPJYly9h0NMlMGSpf/50Q3Yh1UFLw
         uOpNzF2fWv4xFj5cyNxiK7HpHBWI+2hwosBm6pu+gNj7u6FjEfgAkFau4ASkly5Pdqrp
         npnzNcoRlkcMakseM6Je/U7/8nTj6uHcf83Pu31cmPKpwLpJJDWwsrLFfJMe94aAdqUQ
         mrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3MMoYjsJFI5q1wkubdZuY9h3t2X13d1eeSt6VNJO7nc=;
        b=SsQuXrs1/mHQjGtTsGFWG5IWaaE+jIv/VTY7WH5+uyCFC9Hn1QAU+sfq1OXiT0O5HY
         A1Hun3uC2fsARU3M77yTkilcDKFf849ue28txVunQPWC8wD5t8r9kTSxBnqcXEn/SHAN
         +ZzWceHW0LxLFc2mgonJRE3Pkq1HgkP9q/VgZuMBysiDccnyF6B7/mQJZvGMIqPt2ntY
         I/YXObRYOY1D1KFUj08+2qFcorZXJEOptlM1h9F/vhv4Z85x2VXmhD5jH2iYCPp3bWC+
         IVdcaopEGLNddDEcHeVsQ0YwWPcUmVAZAaszQqRuirmujphscJdBm0yiLxguTfnGBxPE
         goAQ==
X-Gm-Message-State: ALoCoQnJx9IDZb/rdf5tqs7a6DYWzlb36bZsGOmcBvP8uyIOYPBYwSDMLJLl6ZDRDlDBKsgTC7yP
X-Received: by 10.42.83.147 with SMTP id h19mr16617185icl.95.1425058846395;
 Fri, 27 Feb 2015 09:40:46 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Fri, 27 Feb 2015 09:40:46 -0800 (PST)
In-Reply-To: <loom.20150227T170215-199@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264503>

On Fri, Feb 27, 2015 at 8:20 AM, Lasse Kliemann <lasse@lassekliemann.de> wrote:
> As far as I understand, a push will always modify (or add) a ref in the
> remote repository. When pushing to branch B, then the ref pointing to the
> last commit in this branch will be moved, provided that this can be done in
> a fast-forward way. Otherwise the push will fail.
>
> The following options exist:
>
> (1) force the push
> (2) fetch, merge, then push
> (3) push to a different branch
>
> I don't want (1), for obvious reasons.
>
> Option (2) implies that a particular person has to do the merge, namely the
> person for whom the push is failing, or in other words: the person
> unfortunate enough not being the first to push. (This reminds me of
> Subversion: whoever tries to commit after someone else has committed will
> have the burden of an update and possible merge.)
>
> Option (3) allows others to recognize the situation, and anyone with
> repository access can do a merge. This is a good thing. However, I am
> confused as to what branch name should be used for this. In Mercurial, we
> would say that a new "head" is created, and anyone can recognize this by
> using "hg heads" and do a merge if he feels competent enough. (A "head" in
> Mercurial is a revision without children.) Can something similar be done in
> Git? I'd like to provide my co-workers with a command which they can always
> use to push their changes to a central repository in order that I can see
> what has happened and do merges accordingly. In Mercurial, such a command
> would simply be "hg commit && hg push -f".

For a high level workflow with pure git, everything must be a branch
or a tag IMHO,
(I cannot really think of other ways).

So maybe you create a bash alias for
alias gitup='git push origin HEAD:${USER}/$(date -Iseconds)'
which would push your current tip of the repository to the remote with
quite a unique name.

Then you could also do a "git commit -a && gitup" to push your changes
to the server
As the integrator you could then integrate branches with
    "git fetch origin && git merge origin/sbeller/2015-02-27T09:34:47-0800"

So it is doable. Though I am not convinced of the workflow.
Maybe you want to look at Gerrit or GitLab  (both are open
source web userinterfaces, where you can push changes to
and approve them)


>Then I can use "hg heads" to see
> if any new heads have grown, and if so, do merges. Upon their next pull,
> these merges would manifest themselves in the repositories of my co-workers,
> and everything will be fine for them. So, im looking for the equivalent of
> that workflow in Git. Thanks a lot!
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
