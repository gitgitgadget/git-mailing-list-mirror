From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] Update git-p4 to be compatible with git-lfs 1.2
Date: Wed, 20 Apr 2016 20:00:36 +0100
Message-ID: <CAE5ih79A2D8xTi9MuOYJ=dU12P5hOsLbw+XXptcnhAATwZvBCQ@mail.gmail.com>
References: <0102015434ee502d-d91a9a46-299f-47b0-a583-104b540200bc-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Ben Woosley <Ben.Woosley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 21:01:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asxNO-0004Cb-EP
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 21:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbcDTTAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 15:00:38 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35668 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcDTTAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 15:00:37 -0400
Received: by mail-oi0-f43.google.com with SMTP id p188so56988407oih.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=xxxRr7B7eEGdTbfYZHqxi4d+plStLehRyAMeuk8mrzs=;
        b=KU8TiNnxHZpAeP1qddvxux6EjoMVi6Sdvvcbq/0/43O/LL3GWi1QdSOrVSaPiwOLao
         TypJjQ+jRxFyEBEvIc2o3WPQSJD3ohQas6Y379Cztp93bXSHsdMF72JIc3D8WCjHoQ0q
         qy9rdn5gHxA7n5ufekuqylKdb1EXIVXgJRCDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xxxRr7B7eEGdTbfYZHqxi4d+plStLehRyAMeuk8mrzs=;
        b=les6U4TZxC4VJXy1TxafqJTEYHgTy0PXttmlMMTvIcZ2oc6JGUdJauGhQjGLsDcddn
         pdIWgmU9EEBz/wf1usT86tPvVvTsBKYUwvYmLxITpEXJxpD/V1EX84/+fYiyy717QT2y
         BSNxOc3ioTkRVlJfB/c3Oh/4VPmQ+1HvESgf09apecHucYIeUEI7PADbJB0jsJNwc7Dx
         ttU+PtCDGX0Ux7vXpnz2+YZag2S5aZJY/40DxiXYhiYx/qwIr9Mr95t/woVjN4/hKMQl
         I5tj8o6n/AAPAsAT7WNJa6Arxfd9ORP4lIdBj0yXpVVMS590yAksBebZnIhhjWzOghTS
         Sg2A==
X-Gm-Message-State: AOPr4FVSGP9EgmgociPCQazm2ftuQkxuEbmpbpqDV4QGniCEBH3NvqQL3P3c8m1bIQpxZdQgOFALJ/r3PtdSYQ==
X-Received: by 10.182.182.35 with SMTP id eb3mr4542575obc.64.1461178836073;
 Wed, 20 Apr 2016 12:00:36 -0700 (PDT)
Received: by 10.202.75.210 with HTTP; Wed, 20 Apr 2016 12:00:36 -0700 (PDT)
In-Reply-To: <0102015434ee502d-d91a9a46-299f-47b0-a583-104b540200bc-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292057>

On 20 April 2016 at 19:28, Ben Woosley <Ben.Woosley@gmail.com> wrote:
> From: Ben Woosley <ben.woosley@gmail.com>
>
> The git lfs pointer output was changed in:
> https://github.com/github/git-lfs/pull/1105
>
> This was causing Mac Travis runs to fail, as homebrew had updated to 1.2
> while Linux was pinned at 1.1 via GIT_LFS_VERSION.
>
> The travis builds against 1.1 and 1.2 both on linux. Mac can't do the same as
> it takes the latest homebrew version regardless.

Is this related to the very similar thread going on here:

http://thread.gmane.org/gmane.comp.version-control.git/291917/focus=291926

Thanks
Luke



> ---
>  .travis.yml | 9 ++++++++-
>  git-p4.py   | 7 ++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 78e433b..71510ee 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -23,7 +23,6 @@ env:
>    global:
>      - DEVELOPER=1
>      - P4_VERSION="15.2"
> -    - GIT_LFS_VERSION="1.1.0"
>      - DEFAULT_TEST_TARGET=prove
>      - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>      - GIT_TEST_OPTS="--verbose --tee"
> @@ -31,6 +30,14 @@ env:
>      # t9810 occasionally fails on Travis CI OS X
>      # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
>      - GIT_SKIP_TESTS="t9810 t9816"
> +  matrix:
> +    - GIT_LFS_VERSION="1.2.0"
> +    - GIT_LFS_VERSION="1.1.0"
> +
> +matrix:
> +  exclude:
> +    - os: osx
> +      env: GIT_LFS_VERSION="1.1.0"
>
>  before_install:
>    - >
> diff --git a/git-p4.py b/git-p4.py
> index 527d44b..6c06d17 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1064,7 +1064,12 @@ def generatePointer(self, contentFile):
>          if pointerProcess.wait():
>              os.remove(contentFile)
>              die('git-lfs pointer command failed. Did you install the extension?')
> -        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
> +        pointerLines = pointerFile.split('\n')
> +        # In git-lfs < 1.2, the pointer output included some extraneous information
> +        # this was removed in https://github.com/github/git-lfs/pull/1105
> +        if pointerLines[0].startswith('Git LFS pointer for'):
> +            pointerLines = pointerLines[2:]
> +        pointerContents = [i+'\n' for i in pointerLines[:-1]]
>          oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
>          localLargeFile = os.path.join(
>              os.getcwd(),
>
> --
> https://github.com/git/git/pull/231
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
