Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989C1CD35
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720246109; cv=none; b=Qq9ATgduqbVjfBs54nIdBsivMHNKXkLZagWqqWnfyZ3iVhpnehPGNNxbFxR/iGnghdQjLUjpvElprVCowsk8AU5SuVm3wsYsKteOTzM7O/fSD4rGgrkaLvYbx350zdndYDfXmy3Z9gID+UqBGfRo1LoAORf3hd3zOsXt2LjO608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720246109; c=relaxed/simple;
	bh=c5OvGykVVMvxinr5zh59v0/89KcQ+zsiSIaOq5ygQf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=luuKVVN23QVeHAR8MGod8+RH7Iyfjjy5xvW2w/eIlozRa1phRU7B4eX8AJVL5WceMqepaCkEHsCGROFrMu2K+4F41ntx1cCw8qKYlVlT/xN6SBJwJuYu4xW4w50a4f1aof8l9kZu2+Wj2j463NjWQk8DMpItnJ+wMA2cKi39Vfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/5WVRP1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/5WVRP1"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fb472eacf4so8015395ad.1
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 23:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720246108; x=1720850908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D6TU/f4DK8z41x9nMQv3kpcK9Qy3+kWRgQs577VTwjk=;
        b=m/5WVRP1+U1/tr7oJoyh6DfDsHNzl41LWzsCzX+QcOchnStPy3ZFsKJWkVlxqnTAub
         y039qkTjFjHwbQ8zvl4x+1wtMW1i9r4Xjv1rupUvMrftdZEsJdD4G1yLSzKTVbQp8M7a
         vgRcFZpv5fqyr4Mo/ASmlnLWiIKcFKL9cyvAOVDSLCekfFMuhua9N2YlthUVjjejHl+t
         z38nUFIBqGDnYgt3TyGg8UwczZ+eDdBxUTvObi2eb4RgG6AZm94nf2zYC4CVs5diQmK8
         3uIv7ZLGC7O/RHY310Q5Zup02lueFP3IKBIn/3RVH7P4SReXT4jV3zHW8hb/zz/PTtTa
         HY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720246108; x=1720850908;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D6TU/f4DK8z41x9nMQv3kpcK9Qy3+kWRgQs577VTwjk=;
        b=K7SnEfQu7Nn5Blx4jKdI8IR/5n1XN9N9UEy34L3s0lzR3I9ibmzBR/4MtCyR/D33xY
         V8eg4YMvLAkIHzBJLgt3kpjZYgr3v7W3WT7vOXuVygRvnE54976hhsO6GTjldIWLptQ8
         UDHdFsOrjE1oXqsuegkgL9yaVn4br7mJXIvMFDRa0KGrW+MYe87ooKbwBIU4MwF+VJAl
         3ELEa9qkqhg6KNihMsY5Z7XNigiyZKPDGN8MoJHOzfzycoZ9v0FvTADQCBEwrHYe6UBx
         re2YUm5w9/MnjsnWZnNICKr2vmI4x71eNc+FhUZIcjtlwJnz1UE5j4EzqKjzfAvr5Bsp
         tFow==
X-Gm-Message-State: AOJu0YyYMtzfmo7OKdv31LbW7q0XwnIjjDeQIZBvdeK3ZwKKKkgmgLYb
	ixehXWIyA4Zk4ZHqxcDzHsUb4HojcpO1QXfmYyNospOyeyrjj2EM
X-Google-Smtp-Source: AGHT+IGbGM4Ze3A9GXiBJl1NFXK12iRlHbB/X41M9Wcywan9mjjMcK+/fryZ4sLxbdQNwwiUlGVHfA==
X-Received: by 2002:a17:902:f688:b0:1f9:cdb2:df4a with SMTP id d9443c01a7336-1fb33e098dcmr50217665ad.9.1720246107524;
        Fri, 05 Jul 2024 23:08:27 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb67ee6ebesm4868155ad.244.2024.07.05.23.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 23:08:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jes=C3=BAs?= Ariel Cabello Mateos <080ariel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitweb: rss/atom change published/updated date to
 committed date
In-Reply-To: <20240704164547.94341-1-080ariel@gmail.com> (=?utf-8?Q?=22Jes?=
 =?utf-8?Q?=C3=BAs?= Ariel Cabello
	Mateos"'s message of "Thu, 4 Jul 2024 16:45:35 +0000")
References: <20240704164547.94341-1-080ariel@gmail.com>
Date: Fri, 05 Jul 2024 23:08:26 -0700
Message-ID: <xmqq7cdz3vdx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jesús Ariel Cabello Mateos <080ariel@gmail.com> writes:

> Currently the published(in rss) and the updated(in atom) date
> used is the authored date. Change it to the committed date 
> that betters reflect the "published/updated" definition and 
> makes rss/atom feeds more lineal. Gitlab/Github rss/atom feeds 
> use the commited date.
>
> The committed date is already used to determine if more items
> should be fetched.

Even though "authored" and "committed" date may be grammatically
correct if you use "to author" and "to commit" as verbs, the name we
use for these two timestamps are "author date" and "committer date"
(in other words, "author" and "committer" are not used as verbs but
as nouns for possibly two distinct people).  So

 * "committed date" (on the title and elsewhere) and "commited date"
   -> "committer date".

 * "authored date" -> "author date".

 * "lineal" -> "linear"?

But your reasoning is absolutely correct about the concept of
"publish" more closely corresponds to the committer date than the
author date, and the change looks sensible.

> Signed-off-by: Jesús Ariel Cabello Mateos <080ariel@gmail.com>
> ---
>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ccd14e0e30..0ef5707557 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -8329,7 +8329,7 @@ sub git_feed {
>  		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
>  			last;
>  		}
> -		my %cd = parse_date($co{'author_epoch'}, $co{'author_tz'});
> +		my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
>  
>  		# get list of changed files
>  		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
