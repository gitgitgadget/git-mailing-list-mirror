Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C81E4AE
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855877; cv=none; b=gVtymCInoE+RcP8UVX1vNAvPtSVR9rnWGmaji/xXpxCO7sDW8Z+vnm3QrsaI0VRCO7lFDVcFM0rpgL7Lz/b247QZDGIapTMlRFEbie981PRJjEoZM+WwwAwWE2O8eIMwKWaKmP67ZC6AHGF4b6lKye9GVqSU5XO+3HfUFxescnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855877; c=relaxed/simple;
	bh=ES65O2oLwSTPSRyXfARWflagkv+tC9kJN+bPgCwQvMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ld8evq993l6R2IACv55sXy920V/P1sabQXKmBK7X3a2qO7lwyEqptwWFQ/3Ag8lp1E+l7L3xoKtyfDyAsQb3BOVC3i/IPfj1ad+7DNDOzJVA4/ABRmXxRPB8srAiO3ffy44VpBa1wjNsu0UhaG4Cr8PmMUign0FQjYx9H/hEI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi6fk5lR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi6fk5lR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45377776935so31594785e9.3
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855874; x=1751460674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI9KRXvHuaZghXhwwbL2koG8dapZFi6/lj5XlCmWegE=;
        b=gi6fk5lR5xT12Yaj2lQMj4OFUzI+ixANiuh3MlPLsSiQoGMJBP+ttKCmzcuszAMjFS
         z8ooRPMS7n6GeJcMnjo3PpNQv/q13Z4Ta4AWdZaqxwPCxwmH2BoYBLtrJaFM/Zh80T27
         9tSteJIcCFeXVbB9xn1zqOIZeySJ3sVK65lBue0CnneBWocriU4xqTKAxnIsiCI7qZLi
         f3ivmg2YGzOg9QkNZ0DsdtgRUOY8cq8VJKo+8n865BJ1eP/giT7QK6wYAFwUmh1nQJc3
         sCjtupyrOvDBi5UzNHHI3+YGxB9PlLk78jjw05WGJZvJ0hCG1m135Vl9FfNMVLaSzZhg
         gLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855874; x=1751460674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI9KRXvHuaZghXhwwbL2koG8dapZFi6/lj5XlCmWegE=;
        b=vKr5uIGNjrgiAlroCS1Qs6pKmHPXlH/N7iSqZ/gJFX2BVP49TxcO6qYxdlikZNgFqd
         R1lcOrvpnPpjcYuhO8ApiuNu3bV9XFKCOTZ+hm9Qi5pzgSEdMlb8pJV4V1W3C0daKVK9
         iBhLfbLlK9dksO0B9ryoRzN8ebK8bQpwVW+l12jaLWEwIr5WwX6LuU9GSvZLJUOU3yXM
         MOjarN6SZbxSokH6i7Fwg8TRRF/mmpNh074b+JzrhQAxJwSds+yU976rsMOLvaN81Ndk
         59j9wG6Jp045oIPzJ4Z5cSSXLHTvWNrrNEUYaAnj3dM4AQw2dXZLUmCbnbay2XbG/bsd
         icKA==
X-Gm-Message-State: AOJu0YwQ9P8N1CY51RQzZmW8bVeEfOkoU3ckyQGsO+bnJGLKGWBNL8Ot
	4IEpez2SXStSVbS9aCmSBTs+cQNZ5hEr8MEvk6oJJc0rDqzvz33lsmukEKvf9Q==
X-Gm-Gg: ASbGncsAZDeWEUpmzuxrGkZ8zImxycPtMOYMkEU35qM9DJcVpnhmMLPSWwHbFJiwlF5
	Yu+gUdgVYG3US9NmqHcY+0rrkXb4tYL7Txe4+bS/zOzQEcyEL64ZdTg5bQfyNl0Q5vkztIcPAKe
	+e1FQ5hJnXOMYX1Olo3JmVvav44OpCTxmRDr9ZoSPQ3o/tL2DcvYkgzjKF+JCWp5SLyjaNSBt5h
	DSaLnwPul7us8hr+ba4oEWW8TPxB1dn24p4devPiHcIMikRfZ9DSH7ljfhoQhcu6T6fboIc0hPj
	aGfkm2h4dNiKiqLjHxFboLI+T9bEX+o7cGaDVdnwa2YIfvwq30OXDwZXUAcj+5Qleo/gj5meZaS
	iD7MG3hhShvrNjAxcRrIEuU60PDdG8AZJzL1QZZd2os9W
X-Google-Smtp-Source: AGHT+IFZdGEWcoQHewPFXLpbJDPacIH4pXMKTxc44nBuyryIriubM4b08eLb76/hX4OzK0boh4tIIQ==
X-Received: by 2002:a05:600c:3e8e:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-45381ae5231mr25172685e9.25.1750855873396;
        Wed, 25 Jun 2025 05:51:13 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382349548sm19446905e9.10.2025.06.25.05.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:51:12 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 0/5] Make the "promisor-remote" capability support more fields
Date: Wed, 25 Jun 2025 14:50:50 +0200
Message-ID: <20250625125055.1375596-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.0.86.g149b275
In-Reply-To: <20250611134506.2975856-1-christian.couder@gmail.com>
References: <20250611134506.2975856-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "promisor-remote" capability can only be used to pass the names
and URLs of the promisor remotes from the server to the client. After
that the client can use this information to decide if it accepts the
remotes or not.

It would be nice if the server could pass more fields about its
remotes and if the client could use that additional information to
decide about the remotes by comparing it with its local information
about the remotes.

This patch series implements this by adding the "promisor.sendFields"
on the server side and the "promisor.checkFields" on the client side.

For example, if "promisor.sendFields" is set to "partialCloneFilter",
and the server has the remote "foo" configured like this:

[remote "foo"]
        url = file:///tmp/foo.git
	partialCloneFilter = blob:none

then "name=foo,url=file:///tmp/foo.git,partialCloneFilter=blob:none"
will be sent by the server for this remote.

All the information passed through the "promisor-remote" capability is
still only used to decide if the remotes are accepted or not. The
client doesn't store it and doesn't use it for any other purpose.

Note that the filter mechanism already exists for a long time and this
series doesn't change how it works. For example, it has already been
possible for a long time to have different repos using the same
promisor remote with different filters. See the existing partial clone
documentation (like "Documentation/technical/partial-clone.adoc") for
more information on partial clone.

The fields that can be passed are limited to "partialCloneFilter" and
"token".

On the technical side, we get rid of 'struct strvec' and we use
'struct promisor_info' to store the data and 'struct string_list' to
store the 'struct promisor_info' instances instead.

This work is part of the "LOP" effort documented in:

  Documentation/technical/large-object-promisors.adoc

See that doc for more information on the broader context.

Changes since v4
----------------

Thanks to Patrick, Junio, Karthik and Justin for their comments on the
previous versions.

There are very few changes compared to v4 and they are quite small.

In patch 1/5, in the commit message:

  - a few sentences were added to explain why using 'struct strvec'
    for the new fields wouldn't scale well,

  - a typo "use use" was fixed.

In patch 1/5, in the code, a BUG() message was improved.

In patch 2/5, in the code, some code comments were added in
fields_from_config().

CI tests
--------

They all passed:

https://github.com/chriscool/git/actions/runs/15846478103

Range diff compared to v4
-------------------------

1:  8a4df71d2c ! 1:  3700939f67 promisor-remote: refactor to get rid of 'struct strvec'
    @@ Commit message
         for different promisor remotes. Unfortunately using 'struct strvec',
         as we currently do, to store information about the promisor remotes
         with one 'struct strvec' for each field like "name" or "url" does not
    -    scale easily in that case.
    +    scale easily in that case. We would need one 'struct strvec' for each
    +    new field, and then we would have to pass all these 'struct strvec'
    +    around.
     
         Let's refactor this and introduce a new 'struct promisor_info'.
     
         It will only store promisor remote information in its members. For now
         it has only a 'name' member for the promisor remote name and an 'url'
    -    member for its URL. We will use use a 'struct string_list' to store
    -    the instances of 'struct promisor_info'. For each 'item' in the
    +    member for its URL. We will use a 'struct string_list' to store the
    +    instances of 'struct promisor_info'. For each 'item' in the
         string_list, 'item->string' will point to the promisor remote name and
         'item->util' will point to the corresponding 'struct promisor_info'
         instance.
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      
     -  if (!strcmp(urls->v[i], remote_url))
     +  if (!p->url)
    -+          BUG("bad config_info (invalid URL) for remote '%s'",
    ++          BUG("bad config_info (URL is NULL) for remote '%s'",
     +              remote_name);
     +
     +  if (!strcmp(p->url, remote_url))
2:  8f3111b4f2 ! 2:  f546756705 promisor-remote: allow a server to advertise more fields
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     +  char *fields = NULL;
     +
     +  if (!git_config_get_string(config_key, &fields) && *fields) {
    ++          /* Split on any comma or space character */
     +          string_list_split_in_place(fields_list, fields, ", ", -1);
    ++          /*
    ++           * Remove empty items that might result from trailing
    ++           * commas, or from items being separated by both
    ++           * commas and spaces.
    ++           */
     +          string_list_remove_empty_items(fields_list, 0);
     +          filter_string_list(fields_list, 0, is_valid_field, (void *)config_key);
     +  }
3:  c91a1ba04a = 3:  3ac73b14eb promisor-remote: refactor how we parse advertised fields
4:  ad68202057 = 4:  b75577eff2 promisor-remote: allow a client to check fields
5:  e8efe62b7f = 5:  149b275087 promisor-remote: use string constants for 'name' and 'url' too


Christian Couder (5):
  promisor-remote: refactor to get rid of 'struct strvec'
  promisor-remote: allow a server to advertise more fields
  promisor-remote: refactor how we parse advertised fields
  promisor-remote: allow a client to check fields
  promisor-remote: use string constants for 'name' and 'url' too

 Documentation/config/promisor.adoc    |  62 ++++
 Documentation/gitprotocol-v2.adoc     |  59 +++-
 promisor-remote.c                     | 401 +++++++++++++++++++++-----
 t/t5710-promisor-remote-capability.sh |  65 +++++
 4 files changed, 499 insertions(+), 88 deletions(-)

-- 
2.50.0.2.g875523421d

