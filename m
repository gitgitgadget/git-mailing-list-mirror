Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC4F2DA742
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107076; cv=none; b=pp2NWfsOjkC5RI5e/wgRfEPSEMN+BHjK97opcktVtQ86EstKs3YBUcj9/TK5a3zpuvMDiSmDtOPHfWtHEqENcrKJWKYM3vwr21XPemEsb2I34FlrkOobTO9RXLWAjexEb19C7WBt4H1zuWVnBVBm1pY0yScbv0wUX3t7EZB32OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107076; c=relaxed/simple;
	bh=agxkhXFcT3oE6Q/O/oBUW6US431cO4z4C8r0cIbUbBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEcQuZjHq1ktjVpVC17FqLbdzIw9ijWjYzbc8DI0iYOPvvso88QPSOwMViTsNGgFf5vGxSSWIDxHhxKCX4R7kuJXlQ7jKDe63myIpxrfTqkrbop32UFS1veudgwYBmM6laY+6zNxLFcP4fcgZXv92ZR0491nSoRvqDI2n/rbmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVl3DSMd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVl3DSMd"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45629702e52so18845035e9.2
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753107072; x=1753711872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFGao59YqhLDmpnZClt+VB+wqeOjPl7HdW74h5WMmX4=;
        b=PVl3DSMdoXki4onR0Ru0oT3AHqywjLhiSAgSSGjK+P7eIASxijuT/XQ65VZs3uNj/y
         5/oDn0o//DffPwybpyoL6sINqIXGN6xclKQLuGSLcz0v4VNo/ek+K6SzTaCjarTPsYST
         96wGD1TtaZcWfwWzvGlWpm1dF9r8THDsjDVV+K3/i1ajlp1t7ybvl+hhtAWAxe15+ziO
         4n/SKhzCKPLzLThxBddYzSq2BYPWL8IzQUJVN8YgB1fWylNUZdE1vZkBpOqQGmWzBbEd
         pvG4ndpEWzv2JJ2jgVpNbc8mULvv+zyaxZBjz1/nOUwqpf0NfbidkPI9+Aio6qpG2TL2
         sqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107072; x=1753711872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFGao59YqhLDmpnZClt+VB+wqeOjPl7HdW74h5WMmX4=;
        b=NSm70jMMY/ixEcjfEaVO4iwDzdgwa+/9t/DvHjDggm3AwaerzdOQB6sGuPjLuWBqHw
         N/OaE3c45vlD6SKSp+HsOs73tHAJa02J1mIq3xcujO1d74Yuu3OjYTubZ1MAXL+HNHPH
         M/NXzcdd7rHmgNFzUGD0mAouoh3Kgwt2Lb6qiwCaKQfO0zBiuBhjA6ATgRBPL1E3OTq6
         rfW3NnjmuaI+WGuJG0K8cOF9kGO3CMeh4RaisMaFgz7Xe4YPSn85u5YWIg8rIRVE31dA
         KtIaRQ1s1WRbJJpq3w3gfzDShi++ZcrXade6BsWDNPruZiFtMzb8dBxQJ9st6B4fRYNq
         XEEA==
X-Gm-Message-State: AOJu0YwWpedZ3kYrKgxnNHSroRK1sUImgOj/6EEZqzcORhlZrzyVr9oH
	jKq99VxH/3BXMLranfnn/zgF1P7RJbtAcFiq1oLIxq/eLWSIryhCUehBEkW1WA==
X-Gm-Gg: ASbGncuRNYYO1Sj0HHlhjGKV7X3HwfGB6HswN6D71oAUkgNRjmL2P3NNryQI6m6svUK
	0CjHGfztOfuCIWHaxBnv3TfWtRKwoTut1Msm0zsa6JuZixXbZqFfulLfMYYwz99yvuOJUjg2lmL
	Rc2rTYJGFFV9Sa1f0ja3EdUQCqY4LtV+ecq+8MOFBJ2f4Pm990pUeTOIJPi74XXCzLqY4/KpePb
	/4rwZHH1/MBmrCJkBb7/Pju2ukxkJu5ZR8k7bzkmRm4MGBEB8oXyGZB4xoFtRrm4IW5w+z6st9u
	uv6GyJS6Ddz6Rxjwe8uunmfLFnJdXnhGARTjZMBBwsP4BDaDx1XKC2TYiytNwFEi5pjPAL9cIPr
	xpQjyv80Lj/kx17B75XlmpC0BtkFtImrSt/MlM0JVSeak2A5Ys64ZTzgAfruZU/rFnG4KnzeHQb
	PUDt9V+smTwD8LuuU=
X-Google-Smtp-Source: AGHT+IGmDQwqNKwAOo6HKVznXFB9snZi0xsDxC6GdrDlEQz+eY/EGm0WSNvA8RlwBkcfITLvl6g+Pw==
X-Received: by 2002:a05:600c:3b15:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-4562e36c7b1mr170420185e9.20.1753107071234;
        Mon, 21 Jul 2025 07:11:11 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2e68sm160885585e9.1.2025.07.21.07.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:11:10 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 0/5] Make the "promisor-remote" capability support more fields
Date: Mon, 21 Jul 2025 16:10:18 +0200
Message-ID: <20250721141056.2283349-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.1.324.gc7d7c83534
In-Reply-To: <20250625125055.1375596-1-christian.couder@gmail.com>
References: <20250625125055.1375596-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes since v5
----------------

Thanks to Patrick, Junio, Karthik, Jean-Noël and Justin for their
comments on the previous versions.

There are a number of changes compared to v5 but they are mostly on
the documentation and commit messages.

  - In patch 1/5 ("promisor-remote: refactor to get rid of 'struct
    strvec'"), we don't check p->url and BUG() if it's NULL anymore.

  - In patch 2/5 ("promisor-remote: allow a server to advertise more
    fields") the commit message has been improved. Especially there
    are now explanations about what we call fields and field names.

  - In patch 2/5 there are the following changes to the documentation:

    - use of "will" has been reduced,

    - "`partialCloneFilter`::" and "`token`::" are used to describe
      these field names,

    - "<field-name>" is used instead of "<field name>",

    - the length of the underline to the "promisor-remote=<pr-info>"
      title has been adjusted

    - the BNF definition of "pr-info" has been improved,

    - it's stated that a given field name should not appear more than
      once for each promisor remote,

    - the BNF definition of "pr-names" has been improved.

  - In patch 4/5 ("promisor-remote: allow a client to check fields")
    the use of "will" has alse been reduced.

CI tests
--------

They have all passed, see:

https://github.com/chriscool/git/actions/runs/16417265102

Range diff compared to v5
-------------------------

1:  3700939f67 ! 1:  87a6ba5c48 promisor-remote: refactor to get rid of 'struct strvec'
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      	}
      
     -	if (!strcmp(urls->v[i], remote_url))
    -+	if (!p->url)
    -+		BUG("bad config_info (URL is NULL) for remote '%s'",
    -+		    remote_name);
    -+
     +	if (!strcmp(p->url, remote_url))
      		return 1;
      
2:  f546756705 ! 2:  0543a42858 promisor-remote: allow a server to advertise more fields
    @@ Commit message
         and "url" information from a server to a client in the form
         "name=<remote_name>,url=<remote_url>".
     
    -    Let's make it possible to pass more information by introducing a new
    -    "promisor.sendFields" configuration variable. This variable should
    -    contain a comma or space separated list of field names that will be
    -    looked up in the configuration of the remote on the server to find the
    -    values that will be passed to the client.
    +    To allow clients to make more informed decisions about which promisor
    +    remotes they accept, let's make it possible to pass more information
    +    by introducing a new "promisor.sendFields" configuration variable.
     
    -    Only a set of predefined fields are allowed. The only fields in this
    -    set are "partialCloneFilter" and "token". The "partialCloneFilter"
    -    field specifies the filter definition used by the promisor remote,
    -    and the "token" field can provide an authentication credential for
    -    accessing it.
    +    On the server side, information about a remote `foo` is stored in
    +    configuration variables named `remote.foo.<variable-name>`. To make
    +    it clearer and simpler, we use `field` and `field name` like this:
    +
    +      * `field name` refers to the <variable-name> part of such a
    +        configuration variable, and
    +
    +      * `field` refers to both the `field name` and the value of such a
    +        configuration variable.
    +
    +    The "promisor.sendFields" configuration variable should contain a
    +    comma or space separated list of field names that will be looked up
    +    in the configuration of the remote on the server to find the values
    +    that will be passed to the client.
    +
    +    Only a set of predefined field names are allowed. The only field
    +    names in this set are "partialCloneFilter" and "token". The
    +    "partialCloneFilter" field name specifies the filter definition used
    +    by the promisor remote, and the "token" field name can provide an
    +    authentication credential for accessing it.
     
         For example, if "promisor.sendFields" is set to "partialCloneFilter",
    -    and the server has the "remote.<name>.partialCloneFilter" config
    -    variable set to a value for a remote, then that value will be passed
    -    in the form "partialCloneFilter=<value>" after the "name" and "url"
    -    fields.
    +    and the server has the "remote.foo.partialCloneFilter" config
    +    variable set to a value, then that value will be passed in the
    +    "partialCloneFilter" field in the form "partialCloneFilter=<value>"
    +    after the "name" and "url" fields.
     
         A following commit will allow the client to use the information to
         decide if it accepts the remote or not. For now the client doesn't do
    @@ Documentation/config/promisor.adoc: promisor.advertise::
      
     +promisor.sendFields::
     +	A comma or space separated list of additional remote related
    -+	field names. A server will send these field names and the
    ++	field names. A server sends these field names and the
     +	associated field values from its configuration when
     +	advertising its promisor remotes using the "promisor-remote"
     +	capability, see linkgit:gitprotocol-v2[5]. Currently, only the
     +	"partialCloneFilter" and "token" field names are supported.
     ++
    -+* "partialCloneFilter": contains the partial clone filter
    -+  used for the remote.
    ++`partialCloneFilter`:: contains the partial clone filter
    ++used for the remote.
     ++
    -+* "token": contains an authentication token for the remote.
    ++`token`:: contains an authentication token for the remote.
     ++
     +When a field name is part of this list and a corresponding
    -+"remote.foo.<field name>" config variable is set on the server to a
    -+non-empty value, then the field name and value will be sent when
    ++"remote.foo.<field-name>" config variable is set on the server to a
    ++non-empty value, then the field name and value are sent when
     +advertising the promisor remote "foo".
     ++
     +This list has no effect unless the "promisor.advertise" config
    @@ Documentation/gitprotocol-v2.adoc: retrieving the header from a bundle at the in
      headers of that bundle or bundles.
      
     -promisor-remote=<pr-infos>
    +-~~~~~~~~~~~~~~~~~~~~~~~~~~
     +promisor-remote=<pr-info>
    - ~~~~~~~~~~~~~~~~~~~~~~~~~~
    ++~~~~~~~~~~~~~~~~~~~~~~~~~
      
      The server may advertise some promisor remotes it is using or knows
      about to a client which may want to use them as its promisor remotes,
    @@ Documentation/gitprotocol-v2.adoc: retrieving the header from a bundle at the in
      form:
      
     -	pr-infos = pr-info | pr-infos ";" pr-info
    -+	pr-info = pr-fields | pr-info ";" pr-info
    ++	pr-info = pr-fields | pr-info ";" pr-fields
      
     -	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
    -+	pr-fields = field-name "=" field-value | pr-fields "," pr-fields
    ++	pr-fields = pr-field | pr-fields "," pr-field
      
     -where `pr-name` is the urlencoded name of a promisor remote, and
     -`pr-url` the urlencoded URL of that promisor remote.
    -+where all the `field-name` and `field-value` in a given `pr-fields`
    -+are field names and values related to a single promisor remote.
    ++	pr-field = field-name "=" field-value
      
     -In this case, if the client decides to use one or more promisor
     -remotes the server advertised, it can reply with
     -"promisor-remote=<pr-names>" where <pr-names> should be of the form:
    ++where all the `field-name` and `field-value` in a given `pr-fields`
    ++are field names and values related to a single promisor remote. A
    ++given `field-name` MUST NOT appear more than once in given
    ++`pr-fields`.
    ++
     +The server MUST advertise at least the "name" and "url" field names
     +along with the associated field values, which are the name of a valid
     +remote and its URL, in each `pr-fields`. The "name" and "url" fields
     +MUST appear first in each pr-fields, in that order.
    - 
    --	pr-names = pr-name | pr-names ";" pr-name
    ++
     +After these mandatory fields, the server MAY advertise the following
     +optional fields in any order:
     +
    -+- "partialCloneFilter": The filter specification used by the remote.
    ++`partialCloneFilter`:: The filter specification used by the remote.
     +Clients can use this to determine if the remote's filtering strategy
     +is compatible with their needs (e.g., checking if both use "blob:none").
     +It corresponds to the "remote.<name>.partialCloneFilter" config setting.
     +
    -+- "token": An authentication token that clients can use when
    ++`token`:: An authentication token that clients can use when
     +connecting to the remote. It corresponds to the "remote.<name>.token"
     +config setting.
     +
    @@ Documentation/gitprotocol-v2.adoc: retrieving the header from a bundle at the in
     +If the client decides to use one or more promisor remotes the server
     +advertised, it can reply with "promisor-remote=<pr-names>" where
     +<pr-names> should be of the form:
    -+
    -+	pr-names = pr-name | pr-names ";" pr-names
    + 
    + 	pr-names = pr-name | pr-names ";" pr-name
      
      where `pr-name` is the urlencoded name of a promisor remote the server
      advertised and the client accepts.
3:  3ac73b14eb = 3:  d566719807 promisor-remote: refactor how we parse advertised fields
4:  b75577eff2 ! 4:  d2a13eabc0 promisor-remote: allow a client to check fields
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
     +
     +promisor.checkFields::
     +	A comma or space separated list of additional remote related
    -+	field names. A client will check if the values of these fields
    ++	field names. A client checks if the values of these fields
     +	transmitted by a server correspond to the values of these
     +	fields in its own configuration before accepting a promisor
     +	remote. Currently, "partialCloneFilter" and "token" are the
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
     +   match the value advertised by the server for the "token" field.
     ++
     +If any of these conditions is not met for any field name listed in
    -+`promisor.checkFields`, the advertised remote "foo" will be rejected.
    ++`promisor.checkFields`, the advertised remote "foo" is rejected.
     ++
     +For the "partialCloneFilter" field, this allows the client to ensure
     +that the server's filter matches what it expects locally, preventing
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
     ++
     +The field names and values should be passed by the server through the
     +"promisor-remote" capability by using the `promisor.sendFields` config
    -+variable. The fields will be checked only if the
    ++variable. The fields are checked only if the
     +`promisor.acceptFromServer` config variable is not set to "None". If
    -+set to "None", this config variable will have no effect. See
    ++set to "None", this config variable has no effect. See
     +linkgit:gitprotocol-v2[5].
     
      ## promisor-remote.c ##
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      	if (accept != ACCEPT_KNOWN_URL)
      		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
     @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
    - 		    remote_name);
    + 	}
      
      	if (!strcmp(p->url, remote_url))
     -		return 1;
5:  149b275087 = 5:  c7d7c83534 promisor-remote: use string constants for 'name' and 'url' too


Christian Couder (5):
  promisor-remote: refactor to get rid of 'struct strvec'
  promisor-remote: allow a server to advertise more fields
  promisor-remote: refactor how we parse advertised fields
  promisor-remote: allow a client to check fields
  promisor-remote: use string constants for 'name' and 'url' too

 Documentation/config/promisor.adoc    |  62 ++++
 Documentation/gitprotocol-v2.adoc     |  63 ++--
 promisor-remote.c                     | 397 +++++++++++++++++++++-----
 t/t5710-promisor-remote-capability.sh |  65 +++++
 4 files changed, 499 insertions(+), 88 deletions(-)

-- 
2.50.1.324.gc7d7c83534

