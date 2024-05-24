Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8786251
	for <git@vger.kernel.org>; Fri, 24 May 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568787; cv=none; b=qhR97NgRBqcOZE5+y3LZI+M7lucTSsrt/fYBxeWGArdr4JNEU+A0sNrirheyIzyxJ+iZ+XMkcaaa9mw1dWRqyuLal/fVeQ7SDkqWOqvCncUqtvwQbiuI7SAe4I1rmWvD3PmH5ZdjPLCBIs09BfeQ85RR6eYoHydTSdG2+acbGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568787; c=relaxed/simple;
	bh=8eTrT6rigEcEc6d8Gg0O9ooUz27bxKwWcaYCU5HxXAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fl04sJ+i0Mpge+sJ5nmV/CoxtdF1XkRAAPfO7kIgdrmj05wTaqxaFiJKaT3kI47wLDHYQD+GjSwuxCtamL0QQC4AIdMIRHBW5xqxKKbdzXqkxtKDneF4CwM05Moe15t20DJCAdEtgYSa6LxOOBBCqyhc8dZH0RbrTuMpS+7LWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnE6PUcZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnE6PUcZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4200ee78e56so32954665e9.3
        for <git@vger.kernel.org>; Fri, 24 May 2024 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716568783; x=1717173583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kot0986BXcOWWtlk3LrVvNCFOZ0dDH06A14/3LIgZI=;
        b=YnE6PUcZHGuIkOkLARAyHqkKT3ZGpb0cGotqMQJraR6L4nec8x89JoPlIFRtQOaxFb
         gxOW8HVL+wNwSOk/+gGk305zidZt21lRGWND1wLO/7UW7fUDtklU4v5/MwAjVLdSI5GU
         6PBzOF7I74olkWzi2jO1fCc+kHQUDxeItcfSKI/mzw1Reqiy+QVFn3wxHrBbzjOVk9K8
         T/NSrQqqf6+xUNfEkdrXiUP3ICC4srwk61StCr7K4uKWVfSBLzULOuWckYtgHGSyI1LQ
         NPAznoSwSsPueS1/Wk3JwEYCN5pkjK3NBwYJY4pR/+gl0weacQFMNr2HWlTyTlzclp8D
         52BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568783; x=1717173583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kot0986BXcOWWtlk3LrVvNCFOZ0dDH06A14/3LIgZI=;
        b=H1hCgT1xHs86pFKw6/NtyEBz62GHvngNex1FmxQhW+NgGo4Vm5lE/Z0+R2jSWwusmO
         dBXniRvHZfeUwtTswa5Zx1otOu98pjB6GQQUUxKFGWpI5H6iZmfIscTV+2IE6glbsLXe
         U5E561U5NY52nrC+NUbj16Dowcc6KkNUi2pAkXuOMowjVbTINZSx0r76rEfQCmkfkl3F
         33LHTgyx4TdO/3GZRrJT/5aY2JcYZOrq4O/fiOuvSn67Hbb9lopnW3Fev5ELJDM19GU0
         Nh7Nb4Zsbx+UABfoqX9ODcQRWrl8GYVFCzBhZY0qaqkTkFz+blE3InIImUBiuyeYDB3k
         mVAw==
X-Gm-Message-State: AOJu0YxhAAcZrqriZaTSj85lPmISm1CN+TI73NvkAfn/mVwuP9YmGAB2
	VTtEjp8M255rN5oxIKDdzFhPUf0Dho0oztmI5270ood0c0XYGfD/IAn/eQ==
X-Google-Smtp-Source: AGHT+IFL9PKe4paD9Js+wxWdiKJLX4S+xqm6v95c5p6j0p0OLVIJ11JZYWhmw/EsWVIDfUVq4Id5Cw==
X-Received: by 2002:a5d:67ca:0:b0:355:25d:a5b0 with SMTP id ffacd0b85a97d-35526c33fc6mr1979439f8f.15.1716568782546;
        Fri, 24 May 2024 09:39:42 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9303sm1976282f8f.88.2024.05.24.09.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:39:41 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 0/3] upload-pack: support a missing-action
Date: Fri, 24 May 2024 18:39:23 +0200
Message-ID: <20240524163926.2019648-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.45.1.219.gbac909a070
In-Reply-To: <20240418184043.2900955-1-christian.couder@gmail.com>
References: <20240418184043.2900955-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Special note and links
======================

This v3 is sent in reply to the v1 as the v2 was mistakenly sent to an
unrelated patch series. 

v1: https://lore.kernel.org/git/20240418184043.2900955-1-christian.couder@gmail.com/
v2: https://lore.kernel.org/git/20240515132543.851987-1-christian.couder@gmail.com/

Rationale
=========

`git pack-objects` already supports a `--missing=<missing-action>`
option, so that it can avoid erroring out if some objects aren't
available.

It is interesting to have `git upload-pack` support a similar way to
avoid sending some objects in case they aren't available on the
server.

For example, in case both the server and the client are using a
separate promisor remote that contain some objects, it can be better
if the server doesn't try to send such objects back to the client, but
instead let the client get those objects separately from the promisor
remote. (The client needs to have the separate promisor remote
configured, for that to work.)

This could work better if there was something, like perhaps a
capability, for the client to tell the server something like:

  "I know how to fetch missing objects from this and that
  promisor remotes, so if you choose to, you may omit objects
  that you know are available from these promisor remotes when
  sending objects to me."

But that capability could be added later as other similar capabilities
in this area could be very useful. For example in case of a client
cloning, something like the following is currently needed:

  GIT_NO_LAZY_FETCH=0 git clone
      -c remote.my_promisor.promisor=true \
      -c remote.my_promisor.fetch="+refs/heads/*:refs/remotes/my_promisor/*" \
      -c remote.my_promisor.url=<MY_PROMISOR_URL> \
      --filter="blob:limit=5k" server

But it would be nice if there was a capability for the client to say
that it would like the server to give it information about the
promisor that it could use, so that the user doesn't have to pass all
the "remote.my_promisor.XXX" config options on the command like. (It
would then be a bit similar to the bundle-uri feature where all the
bundle related information comes from the server.)

Another example use of this feature could be a server where some
objects have been corrupted or deleted. It could still be useful for
clients who could get those objects from another source, like perhaps
a different client, to be able to fetch or clone from the server.

The fact that the new `uploadpack.missingAction` configuration
variable has to be set to a non default value on the server means that
regular client users cannot hurt themselves with this feature.

As `git rev-list` also supports a `--missing=<missing-action>` option,
the first 2 patches in this series are about refactoring related code
from both `git rev-list` and `git pack-objects` into new
"missing.{c,h}" files. Patch 3/3 then adds a new
`uploadpack.missingAction` configuration variable.

Changes between v2 and v3
=========================

The changes since v2 are the following:

  - In patch 2/3, the show_object_fn_from_action() function was
    replaced by using a `static show_object_fn const fn[]`.

  - In patch 2/3, a new parse_missing_action_value_for_packing()
    function was introduced in the missing action API to simplify
    pack-object's code.

  - In patch 3/3, the new parse_missing_action_value_for_packing()
    function is used too.

  - In patch 3/3, the commit message has been improved to make it more
    assertive and clarify how the new feature can be used in the
    context of promisor remotes.

  - In patch 3/3, `TEST_PASSES_SANITIZE_LEAK=true` was removed in
    't/t5706-upload-pack-missing.sh' as leak tests don't pass
    otherwise. Leaks seems to be in existing config and promisor
    related code.

  - In patch 3/3, `sed -n "s/^\?\(.*\)/\1/p"` was replaced with
    `perl -ne 'print if s/^[?]//'` in 't/t5706-upload-pack-missing.sh'
    as the former doesn't seem to work in our "linux-musl (alpine)"
    tests.

Thanks to Junio for his reviews of v1 and v3, and for suggesting the
most of the above changes.

Range diff between v2 and v3
============================

(Might not be super useful as changes in patch 2/3 are not seen.)

1:  0a961dd4f5 = 1:  67c761b08a rev-list: refactor --missing=<missing-action>
2:  410acc6a39 < -:  ---------- pack-objects: use the missing action API
-:  ---------- > 2:  7bf04f3096 pack-objects: use the missing action API
3:  0f5efb064b ! 3:  bac909a070 upload-pack: allow configuring a missing-action
    @@ Metadata
      ## Commit message ##
         upload-pack: allow configuring a missing-action
     
    -    In case some objects are missing from a server, it might still be
    +    In case some objects are missing from a server, it is sometimes
         useful to be able to fetch or clone from it if the client already has
         the missing objects or can get them in some way.
     
    -    For example, in case both the server and the client are using a
    -    separate promisor remote that contain some objects, it can be better
    -    if the server doesn't try to send such objects back to the client, but
    -    instead let the client get those objects separately from the promisor
    -    remote. (The client needs to have the separate promisor remote
    -    configured, for that to work.)
    +    Suppose repository S borrows from its "promisor" X, and repository C
    +    which initially cloned from S borrows from its "promisor" S. If C
    +    wants an object in order to fill in the gap in its object graph, and
    +    S does not have it (as S itself has no need for that object), then it
    +    makes sense to let C go directly to X bypassing S.
     
         Another example could be a server where some objects have been
         corrupted or deleted. It could still be useful for clients who could
    @@ Documentation/config/uploadpack.txt: uploadpack.allowRefInWant::
     +  still get them from somewhere else.
     
      ## missing.c ##
    -@@ missing.c: int parse_missing_action_value(const char *value)
    - 
    -   return -1;
    +@@ missing.c: int parse_missing_action_value_for_packing(const char *value)
    +           return -2 - res;
    +   }
      }
     +
     +const char *missing_action_to_string(enum missing_action action)
    @@ missing.c: int parse_missing_action_value(const char *value)
     +}
     
      ## missing.h ##
    -@@ missing.h: enum missing_action {
    - */
    - int parse_missing_action_value(const char *value);
    +@@ missing.h: int parse_missing_action_value(const char *value);
    +  */
    + int parse_missing_action_value_for_packing(const char *value);
      
    ++/* Return a short string literal describing the action. */
     +const char *missing_action_to_string(enum missing_action action);
     +
      #endif /* MISSING_H */
    @@ t/t5706-upload-pack-missing.sh (new)
     +
     +test_description='handling of missing objects in upload-pack'
     +
    -+TEST_PASSES_SANITIZE_LEAK=true
     +. ./test-lib.sh
     +
     +# Setup the repository with three commits, this way HEAD is always
    @@ t/t5706-upload-pack-missing.sh (new)
     +
     +check_missing_objects () {
     +  git -C "$1" rev-list --objects --all --missing=print > all.txt &&
    -+  sed -n "s/^\?\(.*\)/\1/p" <all.txt >missing.txt &&
    ++  perl -ne 'print if s/^[?]//' all.txt >missing.txt &&
     +  test_line_count = "$2" missing.txt &&
     +  test "$3" = "$(cat missing.txt)"
     +}
    @@ upload-pack.c: static int upload_pack_config(const char *var, const char *value,
        } else if (!strcmp("transfer.advertisesid", var)) {
                data->advertise_sid = git_config_bool(var, value);
     +  } else if (!strcmp("uploadpack.missingaction", var)) {
    -+          int res = parse_missing_action_value(value);
    -+          if (res < 0 || (res != MA_ERROR &&
    -+                          res != MA_ALLOW_ANY &&
    -+                          res != MA_ALLOW_PROMISOR))
    ++          int res = parse_missing_action_value_for_packing(value);
    ++          if (res < 0)
     +                  die(_("invalid value for '%s': '%s'"), var, value);
     +          /* Allow fetching only from promisor remotes */
     +          if (res == MA_ALLOW_PROMISOR)


Christian Couder (3):
  rev-list: refactor --missing=<missing-action>
  pack-objects: use the missing action API
  upload-pack: allow configuring a missing-action

 Documentation/config/uploadpack.txt |   9 ++
 Makefile                            |   1 +
 builtin/pack-objects.c              |  37 ++++----
 builtin/rev-list.c                  |  43 ++--------
 missing.c                           |  53 ++++++++++++
 missing.h                           |  28 +++++++
 t/t5706-upload-pack-missing.sh      | 125 ++++++++++++++++++++++++++++
 upload-pack.c                       |  17 ++++
 8 files changed, 255 insertions(+), 58 deletions(-)
 create mode 100644 missing.c
 create mode 100644 missing.h
 create mode 100755 t/t5706-upload-pack-missing.sh

-- 
2.45.1.219.g07663fd880

