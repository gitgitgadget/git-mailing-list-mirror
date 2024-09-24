Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE293F9D5
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178347; cv=none; b=T5yabSJadG8/T0NjcrR23vwCaVF9Xm846iEmVnAATzRDJAlXD0SwWWgsU6zWjqY7SowmZX3pl2GJgNiZNd6V8pumhS06juTfJD9ZQLF39TnjnJF0XVz+8u2yXunIR9meiHQx72L22pTYFG9VjBNKNs5Z2NQ0AhObjvwSkseIEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178347; c=relaxed/simple;
	bh=ozbCYS3uwZgH/OGYIC8vzCuG7uwxAJ5hz2xCOn21sco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNAPfvrBBN3LngLXNYWSt7O7TZs6qsmXHuXj63dxuq7USM0Rd5TxjX8KRHwafSm1XwvKDgDg2xn4Goby32lG0Z9pN9I2z2tRtD1puZJ9aF49WDQM8YFB4Yu7rvnjo2WfSJ2DZLThwFdkq96F3Ji+0whe6dW84c8733o+6pSstYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4ZVskQR; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4ZVskQR"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so7797158a12.2
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727178344; x=1727783144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhc8J/7kJHGXUQoQv3tpSjCCdgExoTXA9qi7sGJSpy4=;
        b=O4ZVskQRB8y/qcmP+WfLBjvfzeuSR9AQMqc347zBjjzMDliAIJjgbafhDvjJkVWbxX
         NpEbdKQgO5eklk3hUVEgJ6UpM5FDq8g2IUozt3Xo8ZC6WYLoq9CnTGavFtClrwGB+AOd
         JP/FLGZXkHfIT94MgZWLlg+U+SHFaHCXmTf5uB1Z3YlUl6PDkFv13+zCDR5YSm3eE6rH
         UlLh74EUgqROdsopCZk0RKDGJoJSF7ADfODCWGCuAeUBTm155qK4ZNEHzeuqq7T9EwMn
         3IdBjTeY0BPTdplSXSY+VIHXK+tDXQdy+4Tj9/5Mbml87RtMgujtgAUas7Stv8hGKEnr
         QWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727178344; x=1727783144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhc8J/7kJHGXUQoQv3tpSjCCdgExoTXA9qi7sGJSpy4=;
        b=vuiyYvaWuWXShOCnJmJ6l94UN2qqQZOz0jJZo5sS5/GfsmF3ebYjSDOf9NaUhTnssD
         y3dPjEJ0eqvy40Z4I/VrYXI/cTV6nk30zN8KVH52UV3lvG9ajQ2QLV2pEKq0gnP7yFCa
         UmwlVKkVtTAza+eCI4iayXNkKbAJy7RgEPAD5Sa544rhAlcb1kcUQYZx+EDxaiBRASwX
         c79iw8eOIl03VqO+9LO5GR/wRSPI3vf7U+Jfs7AsNyTevLeNkIP9u61/5y1ZA1j0yYyg
         ufp4x5KvQwwES+vrqFbmy0fDWNO516/+NXpNn7mtsjFW8JE0fZCLLPK614CPNPq+B64g
         U8MQ==
X-Gm-Message-State: AOJu0YxaPk+qMEuvkCRw8ZD5rNyATD6sGntbI7zqlZZ0/Iu0jg6+qePi
	ROy0fr3E9zWJGKmNkvVdsCpVpBfzAIMoiGw7Jay+gVMSD7DvQb/os6WwSMSMuoSCdR92EfE5HUI
	83gRAsQojmZl1h4WoIiLnms7fX/0=
X-Google-Smtp-Source: AGHT+IHKIHSJbC7mxCF0hA+PleOptUpUJov6GKdg/VVQ2+Te9ewYt1uXnKLVgR6l5ZyngH84SIPXZdVjT4OpaS2O6Ys=
X-Received: by 2002:a17:907:3f9f:b0:a8d:4631:83a9 with SMTP id
 a640c23a62f3a-a90d4fdf292mr1666732366b.3.1727178344187; Tue, 24 Sep 2024
 04:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com> <20240720034337.57125-2-eric.peijian@gmail.com>
In-Reply-To: <20240720034337.57125-2-eric.peijian@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 24 Sep 2024 13:45:31 +0200
Message-ID: <CAP8UFD1J4JdR-QP9em=_0q8CQZLf9nE7PLE2=kkvxY218fa-ig@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fetch-pack: refactor packet writing
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 5:43=E2=80=AFAM Eric Ju <eric.peijian@gmail.com> wr=
ote:
>
> From: Calvin Wan <calvinwan@google.com>
>
> A subsequent patch needs to write capabilities for another command.
> Refactor write_fetch_command_and_capabilities() to be a more general
> purpose function write_command_and_capabilities(), so that it can be
> used by both fetch and future command.
>
> Here "command" means the "operations" supported by Git=E2=80=99s wire pro=
tocol
> https://git-scm.com/docs/protocol-v2. An example would be a
> git's subcommand, such as git-fetch(1); or an operation supported by
> the server side such as "object-info" implemented in "a2ba162cda
> (object-info: support for retrieving object info, 2021-04-20)".

I agree that reusing or refactoring the new
write_command_and_capabilities() function for more commands can be
done in a separate series that could perhaps also move the new
function to connect.c. Maybe this could be added to the commit message
though.

[...]

> -static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
> -                                                const struct string_list=
 *server_options)
> +static void write_command_and_capabilities(struct strbuf *req_buf,
> +                                                const struct string_list=
 *server_options, const char* command)

In https://lore.kernel.org/git/xmqqfsn0qsi4.fsf@gitster.g/ Junio
suggested swaping the "command" and "server_options" arguments as well
as sticking the "*" to "command" instead of "char", so:

static void write_command_and_capabilities(struct strbuf *req_buf,

const char *command,

const struct string_list *server_options)

The rest of the patch looks good.
