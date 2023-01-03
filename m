Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B70EC3DA7D
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 19:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbjACTgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 14:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjACTgo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 14:36:44 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A3613D0B
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 11:36:43 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q9so3829850pgq.5
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 11:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkKnfV9EaVwmhgKmbIHMZUc+Bj6BEDLymK2OuSTWK0g=;
        b=brpYCbEf5p9S7rIznsNLrCI1W+Mj2zZu31T4wZOrkYznoyIFBIt1X80rttfKyVR+bh
         cT8++8rJZDYtPtiJWLVGkl/nHDYRTQT0LFecYAfRp7/z+sNqibWnRs0UAR1p6mVoFis1
         rY/SgxB3ILPa5cTr13Mc82W5UCf07Yzj2WBUy2xnQIIkvZLw+++aoloeMU0QdX7l8y8L
         IJdqfKaABdGEO8puUS6Th+BjgtBTEX2lEA9GpUT2oaKZ3Nsl1RwtypaYbbyL8G2TXstI
         jK85bATpcqpN6xjoSru9y/xHmRuVzg4sYJVHqvNO8XR1UP/QgV3PX7Q7JuEi5TORSntY
         +RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkKnfV9EaVwmhgKmbIHMZUc+Bj6BEDLymK2OuSTWK0g=;
        b=zQRLnnhonR2wp5r+eVipqmX+bUYQLq5v92cva5hvClQTKQ8QOzWs5sZFm5jttPYTHj
         YbQ+yM1UxIbQWZLqDMAAkTSHszZBusFWHhwAvSGbhYA0CE2DnI8DBx31U1+ieIrNg+2S
         XzhIvUgT22M2BdYBNJC6/5eeLm6bYepiKfOpZcsyeIYNdkd9lRCboVzP2fKZye3lIF34
         7PzSGbkpopJPJ3TRcVs9RCly05c7hcBjGLysJC3GnhS0tDg1WbIHu0+PTW+iY6McAJr8
         6OPjxHo0Jt1B98bWxFwAIEifszF16sRWVePK18/8Z8bWVfMzK3yLk/zGcjqqbP8HQ5yz
         y8yA==
X-Gm-Message-State: AFqh2kreLvgs+3xagRVhaI2hbDwhk6Wg6eEe2eqV3QA+AcElOE/zmco/
        bOd4JVOeagG7o2uu+6RJwTrQII8VXXw=
X-Google-Smtp-Source: AMrXdXtZp1TkjkNKiN29pvRyR5of99UCSKzgzWaFfGOLciICoaNE4NtpApr76VBPrc5Rkzh4ISTT5A==
X-Received: by 2002:aa7:8f30:0:b0:580:9131:7dbb with SMTP id y16-20020aa78f30000000b0058091317dbbmr46474595pfr.26.1672774602337;
        Tue, 03 Jan 2023 11:36:42 -0800 (PST)
Received: from smtpclient.apple ([171.66.133.248])
        by smtp.gmail.com with ESMTPSA id n189-20020a6227c6000000b00571f66721aesm11801408pfn.42.2023.01.03.11.36.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 11:36:41 -0800 (PST)
From:   Brando Miranda <brandojazz@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: feature request - can git submodule update pull/update the repos
 based on the .gitmodule file without additional flags?
Message-Id: <7F5A9722-527A-48C9-9A1C-8499FDDCF02A@gmail.com>
Date:   Tue, 3 Jan 2023 13:36:39 -0600
Cc:     Brando Miranda <brando9@stanford.edu>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I find i have a git submodule file .gitmodule and when I go git =
submodule update, it ignores the stuff I wrote/have in my .gitmodule =
e.g. I have the exact branch I want to use. Why isn't the default =
behaviour of gitsubmodule to obey my .gitmodule file? It is very =
unintuitive. Then what is the .gitmodule file for?

More details:
- =
https://stackoverflow.com/questions/74988223/why-do-i-need-to-add-the-remo=
te-to-gits-submodule-when-i-specify-the-branch=20

copy pasting contents of url:

Why do I need to add the `--remote` to git's submodule when I specify =
the branch in the .gitmodule file?

I want to pull/update the submodules at the right branch. Doing `git =
submodule update` pulls/updates the submodules but it changes to the =
wrong branch even when the branch I want to ALWAYS use is specified in =
the .gitsubmodule file.

Only when I do `--remote` does it work (but then I don't know what other =
unintended consequences it might have in the rest of my submodules).

I want to updat my modules **exactly** as specified in my .modules =
files. How do I do this?

e.g.

```
[submodule "pytorch-meta-dataset"]
	path =3D pytorch-meta-dataset
	url =3D git@github.com:brando90/pytorch-meta-dataset.git
	branch =3D hdb
[submodule "meta-dataset"]
	path =3D meta-dataset
	url =3D git@github.com:brando90/meta-dataset.git

```

Is what I should be running:

```
git submodule update
git submodule update --remote
git submodule init
git submodule status=20
```

----

I did read the --remote:
```
--remote
           This option is only valid for the update command. Instead of =
using the superproject=E2=80=99s recorded SHA-1 to update the submodule, =
use the status of the submodule=E2=80=99s
           remote-tracking branch. The remote used is branch=E2=80=99s =
remote (branch.<name>.remote), defaulting to origin. The remote branch =
used defaults to the remote HEAD, but the branch
           name may be overridden by setting the submodule.<name>.branch =
option in either .gitmodules or .git/config (with .git/config taking =
precedence).

           This works for any of the supported update procedures =
(--checkout, --rebase, etc.). The only change is the source of the =
target SHA-1. For example, submodule update
           --remote --merge will merge upstream submodule changes into =
the submodules, while submodule update --merge will merge superproject =
gitlink changes into the submodules.

           In order to ensure a current tracking branch state, update =
--remote fetches the submodule=E2=80=99s remote repository before =
calculating the SHA-1. If you don=E2=80=99t want to fetch, you
           should use submodule update --remote --no-fetch.

           Use this option to integrate changes from the upstream =
subproject with your submodule=E2=80=99s current HEAD. Alternatively, =
you can run git pull from the submodule, which is
           equivalent except for the remote branch name: update --remote =
uses the default upstream repository and submodule.<name>.branch, while =
git pull uses the submodule=E2=80=99s
           branch.<name>.merge. Prefer submodule.<name>.branch if you =
want to distribute the default upstream branch with the superproject and =
branch.<name>.merge if you want a more
           native feel while working in the submodule itself.
```

----
My install script ends up looking retarded:
```
# -- gitsubmodules
# - set up pytorch-meta-dataset git submodule
cd ~/diversity-for-predictive-success-of-meta-learning/
# adds the submodule to the .gitmodules file & pull the project
git submodule add -f -b hdb --name pytorch-meta-dataset =
git@github.com:brando90/pytorch-meta-dataset.git pytorch-meta-dataset/
git submodule update --init --recursive --remote pytorch-meta-dataset

# - set up meta-dataset git submodule
# adds the submodule to the .gitmodules file & pull the project
git submodule add -f -b master --name meta-dataset =
git@github.com:brando90/meta-dataset.git meta-dataset/
# - git submodule update to fetch all the data from that project
git submodule update --init --recursive --remote meta-dataset

# - initialize your local configuration file
git submodule init
# - check the submodules
git submodule status
```

why do I need to specify the same thing so many times? What is the point =
of the .gitmodules file then at all? **It can't even update things =
properly without screwing up the rest of the subdmodules**

Look at the branchdes:
```
(meta_learning) =
brandomiranda~/diversity-for-predictive-success-of-meta-learning =E2=9D=AF=
 git submodule status                                        =20
 ca81edbf5093ec5ea1a1f5a4b31ec4078825f44b meta-dataset =
(arxiv_v1-200-gca81edb)
 6e60161962ae3fa309335da7aa1c675c75ecca54 pytorch-meta-dataset =
(heads/hdb)
```

they don't even match my .gitmodules
```
[submodule "pytorch-meta-dataset"]
	path =3D pytorch-meta-dataset
	url =3D git@github.com:brando90/pytorch-meta-dataset.git
	branch =3D hdb
[submodule "meta-dataset"]
	path =3D meta-dataset
	url =3D git@github.com:brando90/meta-dataset.git
	branch =3D master
```

----


related:
- =
https://stackoverflow.com/questions/1777854/how-can-i-specify-a-branch-tag=
-when-adding-a-git-submodule
- =
https://stackoverflow.com/questions/74988266/how-do-i-pull-newly-specified=
-submodules-that-i-just-added-in-my-gitmodules-fil?noredirect=3D1&lq=3D1
- cross: =
https://www.reddit.com/r/git/comments/101urnl/why_do_i_need_to_add_the_rem=
ote_to_gits_submodule/
- quora cross: =
https://www.quora.com/unanswered/Why-do-I-need-to-add-the-remote-to-gits-s=
ubmodule-when-I-specify-the-branch-in-the-gitmodule-file




-----
Brando Miranda
brandojazz@gmail.com



