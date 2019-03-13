Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541F820248
	for <e@80x24.org>; Wed, 13 Mar 2019 15:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfCMPGr (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 11:06:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36880 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCMPGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 11:06:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so2264624qtn.4
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ySuKGfgrSUH/xidxrvvmkbSWQFNsuZ8tP7TNU3qrjIM=;
        b=RFVcO7IA7jvkrnUOAJd7FhwLVMM5KBVK6SQMGjRUs/0SB9u0N8Srl+/eTXOFhNU96h
         I9+9Ez3PgvvcJJW4UrDW7/x59nIPgVYx0JGCVOyM5/74FuluFkFDyqZsj5i8ZIxbQKBb
         7p6B21MYGJY+0bHhREfQrZtevvKieYsjqZZ7EiS9q1UNDQmRP4n5slCoJD9wtrKyStRN
         0RpTemCe3d8dRZFYxxlcjPOO8fPUyI4itgaTMr0cOKQUAxYcYvBEzhxJlal2aTnb6weY
         +RJ1Er65NRv2/iivUFSh+Ro8fUMKi+KoMqgSCULaRcWw8ujrVCFnOK6Bu2GDOvgTxPXY
         /2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ySuKGfgrSUH/xidxrvvmkbSWQFNsuZ8tP7TNU3qrjIM=;
        b=PYTXRg3fTwr8JU98z5aaHmgPAz5FMwRNFdrVAL0y3SuFCo6tI1WkjN+WbVUfbPpPDk
         qBaoS/qq88Mxu5zNWwhND8lReywnD7ju0XqG5t+Pmwb7n5/EebhVU2pl738wRKWGZOYf
         c/UsXxnzGOksM1zBmbXeDQa9ojlGIiNOfcCdtdaEqI7+J6cNEOm5Vg6dJT8iE4NOkDto
         e4XA+yDif35uwIO3cocd5odfCIO1PCRrRJACTXFA0JAxsO3yEBh716qfawJVaLUF5pxA
         r7cDJuZWVyKIU5OcGbvHMpyJt+3ZBl93pAPTprvWxQpggJKXqR1gdRTh96gTMHGr29Ir
         nnGg==
X-Gm-Message-State: APjAAAWGjIQKh0NLjluN1hSvamuQhwzO0mVadH7mgq7gEcyoHfFrOBEN
        NucrKBu5QTHaNl0SiscfjMeeiqGB+ZvLxq057Nbtor1/LLdEjw==
X-Google-Smtp-Source: APXvYqy1e67+aLGQ1OxXdO4sc+fTe9osDkUbAHYdYetpFoM/odRtr/SowvH0SCyUuT+bifmA/uUF+RwT70CsoXNuZFw=
X-Received: by 2002:ac8:70d6:: with SMTP id g22mr4569276qtp.90.1552489605881;
 Wed, 13 Mar 2019 08:06:45 -0700 (PDT)
MIME-Version: 1.0
From:   Thomas Kitzinger <th.kitzinger@gmail.com>
Date:   Wed, 13 Mar 2019 16:06:34 +0100
Message-ID: <CALYpq6_n_5kf5gFwki8cuUW=xSB80L4uoicSOL40OnohK1+h0Q@mail.gmail.com>
Subject: Init of submodule within subtree not working
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 Hello,

currently I=E2=80=99m having trouble using subtree to include a subproject
that itself contains submodules.

$ git subtree add --prefix folderB/subtreeproject https:\\xx master --squas=
h

The resulting structure is something like the following:

superproject/
=E2=94=9C=E2=94=80=E2=94=80 .git/
=E2=94=9C=E2=94=80=E2=94=80 .gitmodules
=E2=94=94=E2=94=80=E2=94=80 folderA/
    =E2=94=9C=E2=94=80=E2=94=80 someFileA
    =E2=94=94=E2=94=80=E2=94=80 submoduleA /
=E2=94=94=E2=94=80=E2=94=80 folderB/
    =E2=94=9C=E2=94=80=E2=94=80 someFileB
    =E2=94=94=E2=94=80=E2=94=80 subtreeproject/   <=3D THE SUBTREE
        =E2=94=9C=E2=94=80=E2=94=80 .gitmodules
        =E2=94=9C=E2=94=80=E2=94=80 someFolder/
        =E2=94=94=E2=94=80=E2=94=80 submoduleInSubtree/   <=3D THE SUBMODUL=
E IN SUBTREE

The subtreeproject contains its own submodule and therefore its own .gitmod=
ules.

If I now run
$ git submodule update --init --remote
I get the error
fatal: No url found for submodule path
=E2=80=98folderB/subtreeproject/submoduleInSubtree=E2=80=99 in .gitmodules

The only way I could get the submodule initialized is by manually
copying the contents of the folder/subtreeproject/.gitmodules to the
top-level .gitmodules and adjusting the path accordingly, which is
quite annoying.

Is this behavior intended? Isn=E2=80=99t there a more elegant solution?

Couldn=E2=80=99t git respect .gitmodules not only in the root directory but
also in any sub-directory? I learned it already works for submodules
within other submodules, but apparently not for submodules within
subtrees.

My git version:
$ git version 2.21.0.windows.1


Best regards

Thomas Kitzinger
