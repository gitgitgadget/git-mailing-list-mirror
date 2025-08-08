Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA22253EB
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637884; cv=none; b=bxkSIWvnNVwLcMZs8g8R0WgZ+n/EDWOt6Y03bvWcKXnpyZOiT2/pHNLuqLUzv29KkvqN7cln9yPnF0EuwMHD6H2lLy756ALY/9NKNomVtYucKMO7iWqFDrh3adb9BqFoVCf17Q839VCVzXade7SFpqp2zBTxiAbq+MJe3GlocbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637884; c=relaxed/simple;
	bh=Tb0xqn9QU/uPnSG6ch2ZCzbqPkj9BYqKltFQAgFoivY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcDodCnXuu3cbslx5EIgZJa6AAGYEBpiWa0qj4ILVqtbC40vKpO6xmH9099sMkblAJ6jht6cXct6uraqGoeT1bZKMO3I0GYy2/B/RKanHwqsoClBAmHPL2GJZqoR7Fvtw4pR1+vGInaE07rQ2RZexwQ85sSqoOTtTLIYvKRYS6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxL93xdZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxL93xdZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2400b3008e8so3187805ad.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 00:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754637882; x=1755242682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KutUBv66Tdqs4BROEX1h8nIs57Ip208XoHAXEHSZUvk=;
        b=QxL93xdZE8BYUFBJbVRgNUD47Ita9LYQawW2aOsWzTGBahQkLR91yCrctsL7rJ5hjN
         2fj7l/733H6dJd1LIeTsq1sJ6YZ+WpaIhmqGwaYRtZw4DaAjk1GdDE9lVcRE0GZrLRzG
         bFPsP7CbYkHazJ1vq1DXtw2r9DAifPSw2oYCxebE0IawTrsRdStNQ9r5EnhZOAEPBLmV
         11QK1IIcmfH2++FxbKWHVRVACMlGlakaKAeklTbC7z3ugHdaeIbTDqRKuae+wmwJTmME
         aNLq7B1LOQR7eHNWwIKPxMiSR5K/M7AARQrmvnCvSgMXSRsi6V+YGTZ5H0JPKvi9z5Y3
         6IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754637882; x=1755242682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KutUBv66Tdqs4BROEX1h8nIs57Ip208XoHAXEHSZUvk=;
        b=JUmVoYKfvEO7vvLxsz00myYG1c1inAYJ2gzoqdyAEhn0UlhvmoLYw6UEPSiZB2qv6J
         asc6+xr7LdcQkIYEMvgByq4qY9Ik8v2KTWv76DuBfD6zNLz0zjgbyi2ws0yRh5AQg3NT
         pN5NWcvx1aB6RZXRQI8je6MnWkCG2xdjF/kKV6cPGytZdmhOXbLgXECXtlZVigIvtcfr
         P02D9fRidSQy/9GZehHdN2LJ0lM6cjaROstnLqaleDcdAtyu2SAGunggHChLb8wOpWjO
         JXxsrhSH7/Pgo7ikgJocfCpFTqMp6nmllsNxODzJMplz1go5jy5J63Czm3ScmUVEjj5a
         InnA==
X-Gm-Message-State: AOJu0YwHKnZMlUENNIK9BDJR4TWlGl174Orj3DNv3TMC49mpJyIcJSgr
	yXBJwOai8KoKPUH3NHrMxDm5Zira+rkMmFRlsEeJ/jJu2L66ySjxqRwMpBapfw==
X-Gm-Gg: ASbGncuvqUDfrZoRge6YUG4WLsSOS+57sJ4lsf5OXQRS7HSimhPzXI0DnSEmGAfDgyq
	E55ZPMksZ5nHYlq2P12Tf0JBhJMw5BmVXJ2TpuxO9PN1o35FufTqO6O8FHXnhcyEe1W1HVZkLsN
	vQN/CD2vcM2cN4QS2MvzYDFxEcvsIcwNZk7vy3X6XyS+BVNNz3OgpWTcwBbyLe1v5BEfLMG30SR
	W4EzCe1jY9hv2JSg2DQ4tqvRiOrp9wk0QG40j4JrQaTTAjngnJ5b+7koRUhz0pUlamdetHfwbfS
	wMT6jZ8krcY68ZTJo8AkChq5twmbn+DXzxp2hMi+4a5OoB5eouAAs9FqGPWvmR0fs70eeuNDYRf
	arG53LtlcEJCvQ3NApKJ7FHTBxyIPdg==
X-Google-Smtp-Source: AGHT+IEkdS67zMw0n/qyLV7rcVBM6zoyYYXYNBLyHfNQO0iGgJ2QTxG+eGThdoVwUdR6e9XW/AYo1g==
X-Received: by 2002:a17:902:f68d:b0:240:4b3b:333c with SMTP id d9443c01a7336-242c27041c4mr14381625ad.9.1754637882299;
        Fri, 08 Aug 2025 00:24:42 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899d272sm200693385ad.135.2025.08.08.00.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:24:41 -0700 (PDT)
Date: Fri, 8 Aug 2025 00:24:39 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/3] remote.c: remove erroneous BUG case
Message-ID: <cover.1754637849.git.liu.denton@gmail.com>
References: <cover.1754627874.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754627874.git.liu.denton@gmail.com>

In the case where one pushes a non-existent oid to an unqualified
destination, we encounter the following BUG

	error: The destination you provided is not a full refname (i.e.,
	starting with "refs/"). We tried to guess what you meant by:

	- Looking for a ref that matches 'branch' on the remote side.
	- Checking if the <src> being pushed ('0000000000000000000000000000000000000001')
	  is a ref in "refs/{heads,tags}/". If so we add a corresponding
	  refs/{heads,tags}/ prefix on the remote side.

	Neither worked, so we gave up. You must fully qualify the ref.
	BUG: remote.c:1221: '0000000000000000000000000000000000000001' should be commit/tag/tree/blob, is '-1'
	fatal: the remote end hung up unexpectedly
	Aborted (core dumped)

However, this isn't actually a bug so replace it with an advise()
message.

Changes since v4:

* Put the switch statement refactoring patch last so that we don't get
  compile errors from a missing variable

Changes since v3:

* Include the switch statement refactoring patch as a prelude to the
  functional patch
* Change "if-else tower" to "if-else ladder"
* Shortened the overly long advise() line
* Rebased on latest 'master' to avoid merge conflict introduced earlier
  in the merge cycle (this should be fine since we haven't merged to
  'next' yet right?)

Changes since v2:

* Add t5516 cleanup patch
* Squash test creation patch into the patch that fixes it
* Include the erroneous object ID in the advise message

Denton Liu (3):
  t5516: remove surrounding empty lines in test bodies
  remote.c: remove BUG in show_push_unqualified_ref_name_error()
  remote.c: convert if-else ladder to switch

 remote.c              | 24 +++++++++++--------
 t/t5516-fetch-push.sh | 54 ++++---------------------------------------
 2 files changed, 19 insertions(+), 59 deletions(-)

Range-diff against v4:
1:  d31f320fdb = 1:  d31f320fdb t5516: remove surrounding empty lines in test bodies
3:  3d84072dc7 ! 2:  d21612fca6 remote.c: remove BUG in show_push_unqualified_ref_name_error()
    @@ Commit message
     
      ## remote.c ##
     @@ remote.c: static void show_push_unqualified_ref_name_error(const char *dst_value,
    + 			 "'%s:refs/tags/%s'?"),
      		       matched_src_name, dst_value);
    - 		break;
    - 	default:
    + 	} else {
     -		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
     -		    matched_src_name, type);
     +		advise(_("The <src> part of the refspec ('%s') "
     +			 "is an object ID that doesn't exist.\n"),
     +		       matched_src_name);
    -+		break;
      	}
      }
      
2:  ee6d69bcaf ! 3:  cbda61af5c remote.c: convert if-else ladder to switch
    @@ remote.c: static void show_push_unqualified_ref_name_error(const char *dst_value
     -	} else {
     +		break;
     +	default:
    - 		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
    - 		    matched_src_name, type);
    + 		advise(_("The <src> part of the refspec ('%s') "
    + 			 "is an object ID that doesn't exist.\n"),
    + 		       matched_src_name);
    ++		break;
      	}
    + }
    + 
-- 
2.50.1

