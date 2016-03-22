From: Stefan Beller <sbeller@google.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Tue, 22 Mar 2016 15:14:56 -0700
Message-ID: <CAGZ79kYmoKX1w5X8jE5_yGb3VKricHEwxAianTyt4VUd71qH-A@mail.gmail.com>
References: <CA+DCAeQQQH59Lb43Y4Bi1xktPNoODV11KkUBbKNG1OZ7mDb-UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:15:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiUZp-0006uV-UT
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbcCVWO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 18:14:58 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33373 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbcCVWO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 18:14:57 -0400
Received: by mail-io0-f175.google.com with SMTP id c63so1258128iof.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 15:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Zp0PM9+r8XvjpHFqF/eiywKu5U0feqxd8RuLMOPqP7g=;
        b=kDsduYcDG/iZbNJeWrF8+BeDT30Y9MlbxUwXTTooemgj56yDj7K8S9CqdpzbMQ4lWg
         pQGAwW2OuEBPsoCsn36L/kd2vq2786WkkPi8hdCb5+U34f7HBKO9I02SRJRu6nJkRY6B
         S9hRaE2dXbFOvwi/OCQ/AapE7Fvne/THLUFDRrPGIqN7W7aRutQzL9bZpCFyfFsW/PEr
         m8/e/2/f4B78oQAW3iLeuQ7KsT4BKaO6BiXQdHXredDnJ456cR4DqK6oS+1OQbEt0qkC
         UwzFJt5JOvyyYXqrgkacfZsWT6G0Q2Iy43ObXepsiVThBwlIdADAbIrTr3jw/zVT+ENj
         lceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Zp0PM9+r8XvjpHFqF/eiywKu5U0feqxd8RuLMOPqP7g=;
        b=hV6tDFC4x8t0ICYOtqy/cFVK3XvA8+5a9ZrwTaXDpVYuLQSKpudDv93Q/lyQAyfpOO
         lAJR3mXSoK97dunfkI2xVttxmuYnKLs3++eY2wAtf1A8Oiyu5zx6BVUg/ObztjAqySq6
         G/y6IfU2eKrJpS74/NZPGOeiHFYa3ghwTDQ4Nqh6aZz+a1PVBU5Ew/hwOYjR770jLLqZ
         5RPwwkncnEOPVcGoNRWHg81jMqj13brSUrPLvmcIjGEA4l90z8Muxw3PqXPdYrj8N2VG
         6ZG5dIjvIuNLLnWS5sGPOPaw0wcdOaW3eTyx/ny/TGl8+w/M1u9plEEjQcWDZb+/BAcZ
         rtDQ==
X-Gm-Message-State: AD7BkJLlOmHrkjuaujllniUfVEuZiEYGfDuO73FI83QKalHHDMuT9vNHAmx9b9H6562f31gHxH8XOLxKai34ZvS6
X-Received: by 10.107.158.138 with SMTP id h132mr73316ioe.174.1458684896503;
 Tue, 22 Mar 2016 15:14:56 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 22 Mar 2016 15:14:56 -0700 (PDT)
In-Reply-To: <CA+DCAeQQQH59Lb43Y4Bi1xktPNoODV11KkUBbKNG1OZ7mDb-UQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289577>

On Tue, Mar 22, 2016 at 5:10 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> Hello everyone,
>
> Recently while using git-apply, I observed that if git-apply is used in a
> sub-directory of a Git repository then it silently dies without doing
> anything.
>
> Here's what I did
>
> ~ $mkdir example
> ~ $cd example
> example $git init
> Initialized empty Git repository in /home/mj/example/.git/
> example $echo main >main
> example $git add main
> example $git commit -m 'main'
> [master (root-commit) 97aeda3] main
>  1 file changed, 1 insertion(+)
>  create mode 100644 main
> example $git checkout -b feature
> Switched to a new branch 'feature'
> example $echo modified >main
> example $git add main
> example $git commit -m 'modified'
> [feature 2551fa2] modified
>  1 file changed, 1 insertion(+), 1 deletion(-)
> example $mkdir outgoing
> example $git diff master >outgoing/feature.patch
> example $git checkout master
> Switched to branch 'master'
> example $cd outgoing/
> outgoing $git apply feature.patch
> outgoing $cd ..
> example $cat main
> main
>
> As you observed, patch wasn't applied. Is it intended behaviour of
> git-apply? Usually to apply the patch I have to copy it to top directory
> and then use git-apply.
>
> I tried out git-am to apply the patch ("git format-patch" was used to
> make patch) while being in the "outgoing" sub-directory and it worked
> fine. So why does git-apply show this kind of behaviour?
>
> Thanks,
> Mehul


Think of git-apply as a specialized version of 'patch', which would also
error out if there are path issues. (Inside outgoing/ there is no file found at
./main)

git-am is the porcelain command which is what is recommended to users
who interact with Git and patches.
