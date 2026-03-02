Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358572618
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772427259; cv=none; b=TVKJ0pYdEMt/a3nb9zhOGocmmBXcyJrFnTwP+4ZBs/58LF0MsZRCbFFtJrymrC3aKtl0E66zE49MkobrObzH03uQyyFTvppoBqYOLNPz0WdMQkBfebl2QZCwZU0wOAwCn3sVoeSrpiMBujgKY6XvnYSONYMIB6PMcoxzNL8jhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772427259; c=relaxed/simple;
	bh=MlesWDEpK8cZ/e7HTVcQCK5YTuqIBztbJL3TQmyvbYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bd3fRrozcwFWds/WYcbcc7cTxsZ5a/tpJog6VPmZfFG6ZAGtSx69qz7366YaSOCB7+FLl5vZgradga77yrd30UBiczC7hSnZL7DfeSMaQyrxGWY+UahVHnddB4FumDWJlhF7Okg3OCfpQGEsmoFlZglbOj3GViWg3iJBwLl/yv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JW5dqJW7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW5dqJW7"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a3e79fe2b8so5740675ad.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 20:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772427257; x=1773032057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGkWYmvDmleDkDNeVswUAM2sdduAx1k9KVRcnA7TrEM=;
        b=JW5dqJW7U5rmLZbz9FqfuiEaU6eZa8d0zSs69k9fPA1bLf822xcVGoeSaNk8Fh0gr5
         6nizZ5u0laHQyhNjPKZg4bO/v2mTXVtvG55XMXrVUibevsRRpQQnahb1R3MfahjZc2Q3
         Ufehlc9oW4MBXZVOKde70QYeDFsFJqcZlD+vNxnFp7uyNiWlJ4MobiEpCozzk0yNJuq+
         HAaiVVukk1yHKiYtiKhehUaUv9mOwqKIyDRpVKC6+9Rs+5jcToe5HPa6e89fVFkZM+Il
         y2Ae5OHb8VkWpTGI9CGH4Hw7ZvrpIn0FtLDlibD6mR2yeBt41/kLRG5hko8RF+pv3pJO
         HsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772427257; x=1773032057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGkWYmvDmleDkDNeVswUAM2sdduAx1k9KVRcnA7TrEM=;
        b=Jhof6wn93fFSGOKesvGNYCULWv7djsQaU7xrvG/lxH2UzzLspNkRjtC7bOemp1Ly0G
         6YZs/AjfWCjJiAQcwbJAl8dpjOq5zUeuWnopmrRTv5qaW4tUcpR/+qYevZEvffBrzHRY
         oHZpmODQARgsyzLyaX1p7TKC25yj8ExZ8J4IQlL5l5gBML8Sxs1uh45zhggDNDxJ7kCU
         A5Y1USmPh1nTBsGxMhnpcMasgzuLIb2db1oFsqvP+sk8fFtaqOu8oNeblpBOc53P7B3C
         fBpOk/lwUQVKtVQIzsdXIgqRZjh+2IjgGZ7EkkUjUU9HMsjKIBHeGlMTZhkoJ2yiovkX
         36dQ==
X-Gm-Message-State: AOJu0YxPJC+prbPs/Hz5J3Cbj42+2NAOeRRF2+teb97XAezH53PoI+dQ
	Y0IdpKnuTbLCWw5tOHNSLO72IurqDf8Azm4IgIvrhgIYgPyO22JUr163
X-Gm-Gg: ATEYQzz16ey5PqVz4QDGkFG1tI7JEU0MUU9ft86dHaNusECx4v25ZVICsrd+ZDtLolH
	uUDMbX/L5L71RMIKq3FDxgUOy+hYHCrzcyAkyiJu/PPb/qzJ+0QIoVcjvTP5puruFwvMNC0cO37
	oput2rBEoD8QFEc70crLR9yJtQcjG5vbmPdy0VBn/rYerUebsf9GfRA3e27ZUgq4dj92/xw8h31
	8oMBpEXdndIDrHIG4dKTQJZWBYsaJ3Z1OLcvvMZFgOxt5y7O/1AlI7LWZ6df1hPODb5w4rf3eYw
	uHk1btesYnSU/h8RQ6WIcBAlOH+frFpPsnIfcLlZsWDvbIKO5lW76rXe3GVDlff4zXe2gKyzMOs
	Dz1uwBXIze7e0kEzV4Myd500xuo9bJ0edETM5ZTmnN6eRvODpwodTgdDxiRomfHxQB7Iw2VE5cy
	uFUgPt5uQ36nZvrxKJEaCBmWYcA6TY3Bia92M15DjMmuMgLbMPIsy8AGn/WgHQzGUvxfPjpDSOg
	G7NUUBqvaI=
X-Received: by 2002:a17:90b:3c09:b0:359:8d95:4a57 with SMTP id 98e67ed59e1d1-3598d954d03mr1425091a91.6.1772427257171;
        Sun, 01 Mar 2026 20:54:17 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35982814773sm4241216a91.0.2026.03.01.20.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 20:54:16 -0800 (PST)
Message-ID: <6d87ec49-6f24-42c5-86b2-6a4825607bb2@gmail.com>
Date: Mon, 2 Mar 2026 12:54:13 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] repo: add the field path.toplevel
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com, jayatheerthkulkarni2005@gmail.com,
 valusoutrik@gmail.com, pushkarkumarsingh1970@gmail.com
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <20260228224252.72788-5-lucasseikioshiro@gmail.com>
 <71e42a01-6077-48fc-876e-555431d1288f@gmail.com>
 <9789E676-4DE0-4C4C-BCAC-5BD880A51CE1@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <9789E676-4DE0-4C4C-BCAC-5BD880A51CE1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lucas

> I don't think it can be considered a low-level function, but I
> agree that its name can be misleading.

Hummm...If a function is solely responsible for string concatenation and 
resides in  like path.c, why isn't it a low level function?

I think the key issue lies in the fact that this function's 
responsibilities are not quite appropriate, rather than merely the 
name. Does a string buffer need to understand Git's path formatting 
rules? It should only know how to append bytes, right? Maybe it would be 
better suited as a domain-specific formatter like 'format_path_output()' 
in a higher level module? I am quite uncertain about it.


> In this case, no, it is defined in wrapper.h.

Yes it is defined in wrapper.h. However in wrapper.c we have:

char *xgetcwd(void)
{
	struct strbuf sb = STRBUF_INIT;
	if (strbuf_getcwd(&sb))
		die_errno(_("unable to get current working directory"));
	return strbuf_detach(&sb, NULL);
}

and the for the stfbuf_getcwd(), in strbuf.c we have:

int strbuf_getcwd(struct strbuf *sb)
{
	size_t oldalloc = sb->alloc;
	size_t guessed_len = 128;

	for (;; guessed_len *= 2) {
		strbuf_grow(sb, guessed_len);
		if (getcwd(sb->buf, sb->alloc)) {
			strbuf_setlen(sb, strlen(sb->buf));
			return 0;
...

Notice the getcwd() function, which is indeed a system call, which you 
can check with 'man 2 getcwd' in terminal. Wrapping it in wrapper.c is 
just providing a shortcut, right?

But I don't think using system calls is inherently problematic. The 
issue lies in where this xgetbuf() is placed:

In builtin/rev-parse.c, the print_path() function is inside of 
cmd_rev_parse(), which is like:

int cmd_rev_parse(....){
	for (i = 1; i < argc; i++){
	...
	if (....){
		print_path(....)
	}
	...
}

And your print_path() implement was:

> +static void print_path(const char *path, const char *prefix,
> +		       enum path_format_type format, enum path_default_type def)
>  {
> +	struct strbuf sb = STRBUF_INIT;
> +	strbuf_add_path(&sb, path, prefix, format, def);
> +	puts(sb.buf);
> +	strbuf_release(&sb);
>  }

So this system call is indeed invoked in the loop. Specifically, it gets 
called every time 'git rev-parse' is invoked, and as far as I know it 
should be a command used extensively in like shell scripts...?

Maybe cache-up approach is more robust? For example in builtin/rev-parse.c:

const char *cached_cwd = ...->original_cwd;
if (!cached_cwd)
	cached_cwd = xgetcwd();

for (...) {
	if (...) {
		print_path_with_cwd(..., cached_cwd, ...);
	}
}


> In this case, we need to add them to match the signature of
> get_value_fn. Those values will be useful for all the path.*, but
> if we start to add more than that I agree that we'll need to think
> in a better solution.

Yes indeed.

> Thanks, it's also good to see more points of view. I'm also not
> sure about it :-)

Thank you for the patch again!

Regards,

Yuchen

