From: Stefan Beller <sbeller@google.com>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 3 Jun 2015 11:14:20 -0700
Message-ID: <CAGZ79kYv5Xgfv=3KD0oPrUsJD2Yw-EHu7U=_35FZTm4Rp5hbBA@mail.gmail.com>
References: <loom.20150603T104534-909@post.gmane.org>
	<20150603090654.GD32000@peff.net>
	<loom.20150603T110826-777@post.gmane.org>
	<20150603093514.GF32000@peff.net>
	<loom.20150603T114527-151@post.gmane.org>
	<xmqqh9qoy9sx.fsf@gitster.dls.corp.google.com>
	<004801d09e25$a339b0f0$e9ad12d0$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Ed Avis <eda@waniasset.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 20:15:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0DBb-0003Vz-Ld
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 20:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933426AbbFCSO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 14:14:26 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33279 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336AbbFCSOV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 14:14:21 -0400
Received: by qkhg32 with SMTP id g32so10411520qkh.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2haNVTbHL3DnfO5S6/PxY1li6JMHlS9fNIfI7o9/JOo=;
        b=i9fPWriC72O1R1q2ZHgUdOPKZIO/xl8SFz7K0B2VBLyWEa0h3xT/6Jvt09qE0zXXuO
         F515X4Vo39tsY1Q6thMe1w1Vb8jDgelK5T8rRYlOxk4CAbfFzQIrCYVdBdfs0II/pJBj
         njKjiPD1UB/ohnsQppHmhH9xC+UapEepj+H2KAVmjHVOaJ+mpOdNgtX80nrx8JECww/2
         5MEalthT8d7XKA36fxsh6J0loAcKYLvAagRrusycXOW2qD57qMLa1p4hAcvAuRWtyIlI
         sxjb2PW49lluUqJBakEKoffzgA3Rs7M23jJlf1bAvIdOXaWoeg2bgE98vsNk4fS9uu9y
         U5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2haNVTbHL3DnfO5S6/PxY1li6JMHlS9fNIfI7o9/JOo=;
        b=VzMNO4ADJPqoGVDMIS8XRUn30YQLOHeiDlCoQkBkyP9IpWD0WHxIdGOfRP53LGzKmq
         eMKqY39Hj6qcBxYoNy1u3D5bKyN5xQdEGAgMIfRuBPSissXs+onmsm4zFooqHJkON8ig
         +MVQ+d+PKBKxoq4ldBobXFjZf1N3gCFwYbYlubQ5IO3r5nYisEQcIiceyhhmAr0Ghao/
         A5kvVeBVZce3/g250i8wdTHXtffKUrJKreVnrI4RXUq8gwiP6qNsi4BCIfEVw0BqEA9t
         Cejj/rdPZXT7tes/jRZlhqMIrjagTrW3beCEeFv4B8JRH8mMUYSaK3gXvG040HHgq89i
         20Hg==
X-Gm-Message-State: ALoCoQnAruvrqxn/OG/t0dP32qAAdGaGF104GEKLHVnoNGR0yiWaQelYIyueYIy4tLPbEq1fRDiu
X-Received: by 10.229.58.73 with SMTP id f9mr16716189qch.30.1433355260817;
 Wed, 03 Jun 2015 11:14:20 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 3 Jun 2015 11:14:20 -0700 (PDT)
In-Reply-To: <004801d09e25$a339b0f0$e9ad12d0$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270717>

Maybe the expectation comes from the existing warnings when checking
out branches?

    $ mkdir tmp && cd tmp
    $ git init
    $ echo Hello >foo
    $ git add foo
    $ git commit -am "Hello"
    $ git branch next
    $ echo "world" >bar
    $ git add bar
    $ git commit -a -m "World"
    $ git checkout test
      # no problem so far, just going back one commit on anther branch
    $ echo Kitty >bar
    $ git checkout master # now we get it:
    error: The following untracked working tree files would be
overwritten by checkout:
    bar
    Please move or remove them before you can switch branches.
    Aborting

So in one mode, we do actually warn about contents going missing, and the other
mode is designed to actually make things go missing without any warning.

So maybe the checkout command is *too powerful* ? Looking at the man page:

    Updates files in the working tree to match the version in the index or the
    specified tree. If no paths are given, git checkout will also update HEAD
    to set the specified branch as the current branch.

we're mixing two different tasks here anyway. "Updating files in the work tree"
can be understood as "throwing away all changes until you're back at a specified
safe point". If I were to come up with a name for such an action it's
maybe "reset" or
"reset-file(s)". Though git reset is taken already and does different things.
"reset" sounds as if stuff may go missing, so anyone who types
"reset", (even without
exactly understanding what it does, would assume it is as safe as
typing "rm" probably.

 And "also update HEAD" can be understood as "switch to another branch",
so if I were to invent a new porcelain command for such functionality it may be
called "git switch-branch". And typing switch-branch would be expected
to carry all
the warnings (no updating files in the work tree, when in danger of
losing its content)
