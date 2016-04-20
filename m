From: Stefan Beller <sbeller@google.com>
Subject: Re: problems serving non-bare repos with submodules over http
Date: Wed, 20 Apr 2016 14:05:43 -0700
Message-ID: <CAGZ79kZMOv0r9fRFbP1WV8qFJBm+s=V8=ueFbYvnyFtgV8j9iQ@mail.gmail.com>
References: <20160420152209.GH23764@onerussian.com>
	<CAGZ79kYS-F1yKpNP7jmhTiZT1R_pucUBBTCbmHKZz6Xd6dy8EA@mail.gmail.com>
	<xmqqh9ewukhw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yaroslav Halchenko <yoh@onerussian.com>,
	Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 23:05:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aszJl-0000pI-9S
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 23:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbcDTVFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 17:05:45 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35663 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbcDTVFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 17:05:44 -0400
Received: by mail-ig0-f169.google.com with SMTP id gy3so140127844igb.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=EUYRMMEyPJpxFOhrkuGpilDGDx52K6hnZYHlQem+XY4=;
        b=WMZoxA8G1VWf0YCMqGYdef/YxDifadfEArwfiNLzTKORn3p/u/qBRCv1qADS0wOKMo
         swBQ2Cec0l9FiLkPpMnU/EiNQW/wEpRJKCeCDVLQRqcKVpVD/dHT0meMOdInOIExLmhl
         cnvvf3D/eCXp53ctYEmLiX/bjxUrmG9zd+B22/5VHPOdPWBOqezLvt4AwP3iLenDSJma
         SxxmwrdKbF3/CjkVUyuz4zozkRv/mMmwj5HgGB3z4bJGUsgtCs6Fl34Z6kGcbiJANGko
         PoTzj3stmlbCCMPtY59Nd2pREA0HvIcgKjjcFLw35GkQg61LNtJHrgyGxq5WCten16ct
         Tjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=EUYRMMEyPJpxFOhrkuGpilDGDx52K6hnZYHlQem+XY4=;
        b=ETZCJcg5O9ycdJ0lZAnc2LRKLGS7udY2VhQaL+zftzMRcA4Xh8EYuiMpu0gqYPLiSA
         0YxGyptNVO/a+qitVARAwRqJzET+MqNz73egfx+9IzgsB8Fpff04QVf7voKXJ85WwSEw
         4mjqXYTmpPSyJ0iiSduraHKa6y42V3dtSWyCtzvEItnsRu5sMGSeWREx4H95xnF0cqjz
         6fiDeRgwgrxHxW7EQiDbD3vfWvVCRNQh21hakPHfGG6Jbj3EJNeV08qQe/ZDoCZSyBzU
         hfw0J30bOFcxaLbZ3VEq6wLU+oa+br7y6U3eo3s+4f/TCuv1bRkWu32bVvjC0j7U/IKO
         okSA==
X-Gm-Message-State: AOPr4FWUJBYMn0Fiubx1JpIslEsTIeZA51w43bZTHNRK9tyBtoWb1YlWT/J692fqthC8Uwlq62c8BbtRmsr2mNWy
X-Received: by 10.50.111.15 with SMTP id ie15mr3895111igb.94.1461186343245;
 Wed, 20 Apr 2016 14:05:43 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 20 Apr 2016 14:05:43 -0700 (PDT)
In-Reply-To: <xmqqh9ewukhw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292078>

On Wed, Apr 20, 2016 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> 1. After cloning
>>>
>>>     git clone http://localhost:8080/.git
>>>
>>>    I cannot 'submodule update' the sub1 in the clone since its url after
>>>    'submodule init' would be  http://localhost:8080/.git/sub1 .  If I manually fix
>>>    it up -- it seems to proceed normally since in original repository I have
>>>    sub1/.git/ directory and not the "gitlink" for that submodule.
>>
>> So the expected URL would be  http://localhost:8080/sub1/.git ?
>>
>> I thought you could leave out the .git prefix, i.e. you can type
>>
>>      git clone http://localhost:8080
>>
>> and Git will recognize the missing .git and try that as well. The relative URL
>> would then be constructed as http://localhost:8080/sub1, which will use the
>> same mechanism to find the missing .git ending.
>
> I may be missing the subtleties, but if you are serving others from
> a non-bare repository with submodules, I do not think you would want
> to expose the in-tree version of the submodule in the first place.

Well I would imagine that is the exact point.
If I was not trying to expose my state, I could ask you to
obtain your copy from $(git remote get-url origin) just as I did.

I would imagine, if I have a problem with some repo I can tell my
coworker or others to get my copy to took into that exact state.
(Or I want to transfer state from workstation to laptop to
continue working)

Without submodules this workflow works. So I'd expect it
to work with submodules as well eventually. Also we probably don't
want to mix cloning the superproject from this non bare repo and
the generic submodule locations as the superproject may have
advanced submodule pointers to commits which are not present
in the generic submodule remotes.

So for the non-bare case I would really expect to be able to "copy"
the remote including submodules from that remote?

We could reason about only providing this for the superproject though
and not for submodules, i.e. cloning from the non bare submodule
could be not supported. (If you really want that non bare submodule,
you can still clone it manually from

    $GIT_DIR_SUPER_PROJECT/modules/$MODULE_NAME



>
> These $submodule/.git files point via "gitdir:" to their real
> repository location, don't they?

Yes they do.

> And I would think that they are
> what you would want to expose to the outside world.  Your in-tree
> submodules may come and go as you checkout different branches in
> your working tree, but these copies at their real locations will
> stay.

Right instead of cloning $WORKTREE/sub/.git you rather want
$GITDIR/module/sub

(GITDIR and WORKTREE from the superprojects point of view)

The problem with a copy of a superproject including submodules is
the way cloning submodules work.

  1) clone the superproject
  2) for each gitlink in the tree, consult the .gitmodules file
  3) if we have a match in the .gitmodules file, clone from there

So currently the protocol doesn't allow to even specify the submodules
directories. In case the remote superproject is non bare in 1) the remote
would need to advertise the submodule repository URLS separately,
such that the cloning can be performed from those direct copies.


Thanks,
Stefan

>
>
