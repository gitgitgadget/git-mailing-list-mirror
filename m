Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56A6EB4C
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308524; cv=none; b=R/1bZnEXxu8YWyMiT2isuKqG7Dc6zbfu176hOet126QFz7wq0gUJwXeLZPUcGUQLQCpA3wT8ysksYDzuE0CWmyfEK8gL8DfC3KRrQuLZM/93HnaR9HTqRla/44wEhEThxp5zx/Rd7iJOs88lv2h72FbD03pMTkPZS/MrZfQB56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308524; c=relaxed/simple;
	bh=QjfnwvAv9bpFoHpX5RtBrnkU/eOCPMEc+3jMucvmzks=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m0kP4xGQYaXCiDcFyzebuc8kZR3q4PL8yXtWtXeUFpc/e9koThFuPvH53rZesgeMSlwxVKo5GU+wI9e7mTbXj/6Wrwq8UmAiyyO9ldNzJd06kqR/mmZU5Kb5WaqiLK/j/kuFRNGNPkh+O3JceFGgg2mlG62V3uVpN2+Wv7rWJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3ofMmKV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3ofMmKV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41550858cabso31572035e9.2
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713308520; x=1713913320; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfSxg8PymsKkbveUqncR2WramDSwaPmFPwPfikBbRbw=;
        b=l3ofMmKVmpyzhTaUSa0x8xKd12Cj4nQaoO1aBML5YQSoWSxR6aC0XlqYZJSiTDkSKG
         UHVR73qISNYTBVJAzYnoxKCvMw95Iu6r3AQ0ggTHXHSA38+pIR4/KxwH8XbiuTksNxq7
         zm+i8Z8W6qYNdflCEncMtHffheboOTjD81T8+ktDKGWcUmTte8TN2FY0pTik7xiZ0kCN
         0tlAEetKe08qRnHfRfPmX9U2wsDIPw2oDF8jYLfejCT5PWn++gRMDjWQsXgfcU/Q/6wU
         xpk/WO3J1f4zPrvWHCCPCIkLkx7rkb10Bg46J/VFmKZkdvGuDqXdduO4Cm0G9wdfNwDh
         CXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308520; x=1713913320;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfSxg8PymsKkbveUqncR2WramDSwaPmFPwPfikBbRbw=;
        b=Pw2HzI5TZr9Qy+ltwBmMGx8iXynKPGfMkl0c2+xADSL67OdltIllrooRGkfS9YPjoZ
         +a+ORLweRu8IX4TbKvXhuRIx7Nsp0oRHFwQUSyy5dC/fMfQlJ25xqonRekNVZx/cc1YV
         +7fYSudwXhOe0c/Rl9FMR0JqesOObrkEjl7GbugoqEb0kJwO8JRdfvpI+zHuqQcLpaFm
         sH+7TWJc/8Ry0CtOAvlv/cDUHAqKn9p9DTxrv7Xf2slei2y+9N4zXkJNkE3JCYsjqmWy
         OW3VRI4QVJUMUg5S+hUgG9B3bh5lJeGTC5Qw+Q3bnvM/GUDqXL7PKL0mvJP6NRtjrnaI
         b4Zw==
X-Gm-Message-State: AOJu0YzX/nDwsr9GJ2bto0BAsaLWz8xiOQF3AV4l2fB67+S99bvBBxId
	pOejR6MyCPhS4pV/JWnoueWs57jxIpy80i6EnBMWbzM1QrIzTzGcSRbipQ==
X-Google-Smtp-Source: AGHT+IHti6g3OqFBynOxqpk5lsRXYyxL8yfGqD84XH0RBKXe21T4Bpm7H4+Ljl0QAs/nIzElBd6Isw==
X-Received: by 2002:a05:600c:548c:b0:418:a427:8445 with SMTP id iv12-20020a05600c548c00b00418a4278445mr1514755wmb.14.1713308519793;
        Tue, 16 Apr 2024 16:01:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b00416a43d60e6sm383650wmo.39.2024.04.16.16.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:01:59 -0700 (PDT)
Message-Id: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
References: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Apr 2024 23:01:49 +0000
Subject: [PATCH v5 0/8] docs: recommend using contrib/contacts/git-contacts
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>

Make git-contacts more prominent in our docs.


Notable changes in v5
=====================

 * Drop mention of "/usr/share/..." as an "installed" path for
   "git-contacts"; instead point users to the script as a relative path
   inside the Git codebase
 * Minor wording tweaks to commit messages


Notable changes in v4
=====================

 * Avoid using "should" for guidance around using "git-contacts"
 * Clarify where to find the "git-contacts" script (because it's not a
   default builtin command)


Notable changes in v3
=====================

 * Refer to GitGitGadget via a link to MyFirstContribution (instead of
   sending readers to GGG's homepage directly)
 * Soften the advice for using git-contacts


Notable changes in v2
=====================

 * Improve existing mention of git-contacts in SubmittingPatches (instead of
   adding a separate, entirely new paragraph)
 * Add example usage of integrating git-contacts with git-send-email with
   the latter's --cc-cmd flag.
 * Various smaller fixes to SubmittingPatches

Linus Arver (8):
  MyFirstContribution: mention contrib/contacts/git-contacts
  SubmittingPatches: clarify 'git-contacts' location
  SubmittingPatches: mention GitGitGadget
  SubmittingPatches: quote commands
  SubmittingPatches: discuss reviewers first
  SubmittingPatches: dedupe discussion of security patches
  SubmittingPatches: add heading for format-patch and send-email
  SubmittingPatches: demonstrate using git-contacts with git-send-email

 Documentation/MyFirstContribution.txt | 10 ++++
 Documentation/SubmittingPatches       | 73 ++++++++++++++++-----------
 2 files changed, 53 insertions(+), 30 deletions(-)


base-commit: c2cbfbd2e28cbe27c194d62183b42f27a6a5bb87
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1704%2Flistx%2Freviewers-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1704/listx/reviewers-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1704

Range-diff vs v4:

 1:  ad469e4e6db ! 1:  d2c9551ee0e MyFirstContribution: mention contrib/contacts/git-contacts
     @@ Documentation/MyFirstContribution.txt: $ git send-email --to=target@example.com
       NOTE: Check `git help send-email` for some other options which you may find
       valuable, such as changing the Reply-to address or adding more CC and BCC lines.
       
     -+:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
     -+part of the core `git` binary and must be called separately. Consult your +
     -+package manager to determine where it is located. For example&#44; on Ubuntu-based +
     -+systems it could be installed under +
     -+`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
     -+with `perl ...` if it does not have the executable bit set.]
     ++:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
     ++not part of the core `git` binary and must be called directly. Clone the Git +
     ++codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
     ++in your system).]
      +
      +NOTE: If you're not sure whom to CC, running `contrib/contacts/git-contacts` can
      +list potential reviewers. In addition, you can do `git send-email
     -+--cc-cmd='/path/to/git-contacts' feature/*.patch`{contrib-scripts} to
     ++--cc-cmd='contrib/contacts/git-contacts' feature/*.patch`{contrib-scripts} to
      +automatically pass this list of emails to `send-email`.
      +
       NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
 2:  c43de19d867 ! 2:  92d72a8a25a SubmittingPatches: clarify 'git-contacts' location
     @@ Metadata
       ## Commit message ##
          SubmittingPatches: clarify 'git-contacts' location
      
     -    Use a dash ("git-contacts", not "git contacts") because the script
     -    is not a core builtin command that is compiled into the `git` binary.
     -    This also puts the script on one line, which should make it easier to
     -    grep for with a loose search query, such as
     +    Use a dash ("git-contacts", not "git contacts") because the script is
     +    not installed as part of "git" toolset. This also puts the script on
     +    one line, which should make it easier to grep for with a loose search
     +    query, such as
      
              $ git grep git.contacts Documentation
      
     -    . Also add a footnote to describe where the script could actually be
     -    located, to help readers who may not be familiar with such "contrib"
     -    scripts (and how they are not accessible with the usual "git
     -    <subcommand>" syntax).
     +    Also add a footnote to describe where the script is located, to help
     +    readers who may not be familiar with such "contrib" scripts (and how
     +    they are not accessible with the usual "git <subcommand>" syntax).
      
          Signed-off-by: Linus Arver <linusa@google.com>
      
     @@ Documentation/SubmittingPatches: security relevant should not be submitted to th
       mentioned below, but should instead be sent privately to the Git
       Security mailing list{security-ml-ref}.
       
     -+:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
     -+part of the core `git` binary and must be called separately. Consult your +
     -+package manager to determine where it is located. For example&#44; on Ubuntu-based +
     -+systems it could be installed under +
     -+`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
     -+with `perl ...` if it does not have the executable bit set.]
     ++:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
     ++not part of the core `git` binary and must be called directly. Clone the Git +
     ++codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
     ++in your system).]
      +
       Send your patch with "To:" set to the mailing list, with "cc:" listing
      -people who are involved in the area you are touching (the `git
 3:  cd941704176 = 3:  7c4cc5a91f0 SubmittingPatches: mention GitGitGadget
 4:  44470a5d70e = 4:  621912a64fb SubmittingPatches: quote commands
 5:  15f9356ff97 ! 5:  8f44343c482 SubmittingPatches: discuss reviewers first
     @@ Documentation/SubmittingPatches: letter.
      +mentioned below, but should instead be sent privately to the Git
      +Security mailing list{security-ml-ref}.
      +
     -+:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
     -+part of the core `git` binary and must be called separately. Consult your +
     -+package manager to determine where it is located. For example&#44; on Ubuntu-based +
     -+systems it could be installed under +
     -+`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
     -+with `perl ...` if it does not have the executable bit set.]
     ++:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
     ++not part of the core `git` binary and must be called directly. Clone the Git +
     ++codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
     ++in your system).]
      +
      +Send your patch with "To:" set to the mailing list, with "cc:" listing
      +people who are involved in the area you are touching (the `git-contacts`
     @@ Documentation/SubmittingPatches: patch, format it as "multipart/signed", not a t
      -mentioned below, but should instead be sent privately to the Git
      -Security mailing list{security-ml-ref}.
      -
     --:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
     --part of the core `git` binary and must be called separately. Consult your +
     --package manager to determine where it is located. For example&#44; on Ubuntu-based +
     --systems it could be installed under +
     --`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
     --with `perl ...` if it does not have the executable bit set.]
     +-:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
     +-not part of the core `git` binary and must be called directly. Clone the Git +
     +-codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
     +-in your system).]
      -
      -Send your patch with "To:" set to the mailing list, with "cc:" listing
      -people who are involved in the area you are touching (the `git-contacts`
 6:  e889e64bd45 ! 6:  fd8ad38cab0 SubmittingPatches: dedupe discussion of security patches
     @@ Documentation/SubmittingPatches: letter.
      +security relevant should be submitted privately to the Git Security
      +mailing list{security-ml}, instead of the public mailing list.
       
     - :contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
     - part of the core `git` binary and must be called separately. Consult your +
     + :contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
     + not part of the core `git` binary and must be called directly. Clone the Git +
      @@ Documentation/SubmittingPatches: Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
       `Tested-by:` lines as necessary to credit people who helped your
       patch, and "cc:" them when sending such a final version for inclusion.
 7:  81556298599 = 7:  b23c73459cc SubmittingPatches: add heading for format-patch and send-email
 8:  84b1cf3f914 ! 8:  911d4f2a0e5 SubmittingPatches: demonstrate using git-contacts with git-send-email
     @@ Documentation/SubmittingPatches: trial merges of your topic to `next` and `seen`
       work by others conflicting with your changes.  There is a good possibility
       that these people may know the area you are touching well.
       
     -+If you are using `send-email`, you can feed it the output of `git contacts` like
     ++If you are using `send-email`, you can feed it the output of `git-contacts` like
      +this:
      +
      +....
     -+	git send-email --cc-cmd='git contacts' feature/*.patch
     ++	git send-email --cc-cmd='contrib/contacts/git-contacts' feature/*.patch
      +....
      +
       :current-maintainer: footnote:[The current maintainer: gitster@pobox.com]

-- 
gitgitgadget
