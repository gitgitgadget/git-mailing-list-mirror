From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Subtree with submodule inside?
Date: Wed, 6 Aug 2014 13:18:22 -0500
Message-ID: <CAHd499AmY+EYXAK8h_oYiOn-amnNrE1+a7qsQ4x7bCOVsJDxcw@mail.gmail.com>
References: <CAHd499CaCeHYGZSQeY8MRVnnjXBTgDy=OUqBYqNd1e5GiKre_A@mail.gmail.com>
	<xmqqk36lmrpl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 20:25:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF5uK-00049i-9k
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 20:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340AbaHFSZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 14:25:48 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:43701 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257AbaHFSZr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 14:25:47 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so4643974vcb.37
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mM1a7UbMpYaNXN7MHxMAJ5yRh1bRscR9IKImfQt38Bk=;
        b=S+wBV17ctd93S0kSQHhSWAyQSlcaGaYO4mNr859V8m4wH5oaTaB99rUKzCO4HZml1z
         GMYvQJ12IhL7wl7SjRBxN1/Rnk/CYzmRDKfQ3A26SeIo87Rtw5FFQcENFW/JB0Ocs/2T
         IhCZLXyHgEF8++osGvplTsccV0gwPCbIr06G/E9B7v4fAAum4iixV01y4QNfwpu5YFBO
         CG7BcQc1HB7UcnAV/2oFCHVBawG0ede38D1WzmrpVAiyhGkvfDtHVgGAq3/cL6Y89Kwd
         CYOBpIQhiJN24r224mDMH5i8uUv35r9Bst+r76OXdfvQ5b0NtZ8EvhjiWg+F6Wdyg0vG
         VVhw==
X-Received: by 10.220.252.198 with SMTP id mx6mr12145618vcb.15.1407349102581;
 Wed, 06 Aug 2014 11:18:22 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Wed, 6 Aug 2014 11:18:22 -0700 (PDT)
In-Reply-To: <xmqqk36lmrpl.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: y1QhMljY_K-kRZH8hWfivKAu348
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254885>

On Wed, Aug 6, 2014 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> My knee-jerk reaction would be "subtree would break submodules
> badly, don't use it" ;-).
>
> After all, I invented subtree merge as an ugly interim workaround
> before submodule subsystem got into a usable shape, hoping that new
> projects can use submodules without resorting to subtree merges.

(Sorry Junio, I forgot to "Reply all" and accidentally sent this only
to you. Resending to group)

Hi Junio. I agree it certainly does sound evil and defeats the purpose
of the goal of ultimately creating a simple workflow :)

Could you go over how you feel the submodule system got into "usable"
shape? It still seems to still have all of the problems I still hate:

* If you branch a production branch to implement a feature that also
impacts the submodule, you need to branch the submodule. There is no
easy interface for this and rather clumbsy, especially if people are
using GUI tools like SourceTree (most of the people on my team are).
* Pull requests do not include submodule changes in the review (we use
Atlassian Stash). So 1 pull request per submodule has to be performed
and they have to be merged in the appropriate order.
* Submodules complicate an otherwise beautiful workflow that Git is
supposed to provide (branching) in many ways, and also there are
restrictions on the order in which you modify parent repository vs
submodule.

If I'm going to put my common code in a separate module for the
purposes of splitting apart projects that depend on the common code, I
want the workflows that Git provides to remain simple. Subtrees seem
to do that, you just sync with the common repo every now and then.
