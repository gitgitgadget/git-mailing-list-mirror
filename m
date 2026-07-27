Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36C3BBFB1
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134414; cv=none; b=EXHIIFXrQe6PixVn/H2r+V38vsVwihbWihUfZq0/NquzX11ZIflwoTCX5E4tuhc3R4qJ1E15OFiokUnhJ6cwfqzJ+rMeRXPuuC049aaN36/ljcf34YfX2vuaGjwW18NgIeixxvGpe2gQXcKVMpSmJzlybR8nGTtdpo4/kXYAnV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134414; c=relaxed/simple;
	bh=LFkfKCfJ2a3HRMZn7nBQ4jJ2xpcTROd9N1auKs9nRtQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Jc6SlPg7tlUqxiOkVX/rdQkguYotrpIkYKXe0jeiYFOlLelSvvBL/n2ZR67+Gf7tBfhIzzpnziGazUsOqpH6ecfdpD6cTivAkwu9K66W3FCMhZsTlZ+3xdStX3Gtz3Z6S651IGV2qYr7DJuFC7PJW4ImrOcdnKbkZoS5UUP/qZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvlyIPrY; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvlyIPrY"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1828971a12.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 23:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785134412; x=1785739212; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jjx/UYVIbX650peoTpB0zAEGrpWyYhn7BF4JUiKUI/E=;
        b=rvlyIPrYloqGv3pQBPF6O24DdH8z7CM5wTZUyiB6NohD8bfJCVn+LifWgncLUsxi4L
         HCa5W6jp0TRMF2Ls2pvzSxvldoynonhadmt9yypTekilQ/kxlg/Nt+cAZcvCKor76v/s
         pMBpfI1NpmHca4H3h7dIvdiGHwMGUasxTOWGC3hyJ/FCPAQDrXHTNu0bZi6Xo2RDVPSs
         W4At1bv+63xyTlDn2m4lWTJgyoVIrJN5iGGtzFt5jxD+u/T+NyAC2Nzo3aLzn+qebylC
         1+0VJH6bw2VsjFZknXazapwkqDo1+i7bzwwShQXN9rC6C2sVij+dX32eAip7/cawfI92
         XTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785134412; x=1785739212;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jjx/UYVIbX650peoTpB0zAEGrpWyYhn7BF4JUiKUI/E=;
        b=iI9CZzBP6i/c0ttn063ppcGVQm1xdJcdqJUs2QBLHNl7ajIRWyVoYolCSG2hc1bdzI
         l2dV5INw7M8fcdLv9S+yFMrtNv1g0GXrQSbDV9Jfv6H8MdL7CgdNsTQq8KKbePCt4KBJ
         BKu2YRvHFRi4YkzUFoobG2YeqRE6IUqSF70EniqMQO5L062m29sc9I8sfdqbAOoFYT3A
         sP2Ov/XyVE3yQ5KFzyIQ8477njYjAitQlgyP+e9QodcM7Iq0jWpZAbHe4ezUCxElmxTO
         1xWrpktpSVtP6rVYTSDNkkAORCpzBlsIxunNY039W6gNRvsFfxfrliVDY9xbylzkP4rA
         l5NQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3Yo4DlduWNV3olXe8EYH/NjMH5NZI0t1qmYLg3TE5rBagUcALdkoOwO2tJg053XsSKC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OnjCLZdpZsRzAW3n20ZxuKR5BBIRdyJt1yDfC0UnY9Akw3oK
	pnXLuw7BIfaz9AjlSnDgDwZi8TMYEW/gR2l6w8UfS7x4TYClNORXln2HbGS7BXG+
X-Gm-Gg: AR+sD10j/mVLULl3ekYQGb0ZyoPuoDqWabeNlPOVE9qNDA8B859wQBEu7oJAVecgnFS
	WvljJmWL1oGgKRfEx/hJzF5yZp292O7YodkAvmmAXgL3ZBnbakXzKytG6g7hp8G8fWWDtdHDLog
	dkr2unMq32flbwo7EkJ3F+vW2mz/GL0NdeWuQt2MXkpYMLG5V6ackgCqFfpaZODgFSqfN/D5Rcs
	MN3AwX+L5VYjwjqQBTooPqLWsXEnXry+amrrvTvWwpuBTCVVNcbcC+DaeqeTEMOq8EebSgeERRN
	lveZy5BOhkCbC9TrRKoqqPp3p9YOPcFLExMY1PRYQqfPgKr1XdZph7z7bfpAPMnvgDHnEe3ZMHL
	DYgEV2b+5Y1nzBBNh4e+6oEvtIBhDDw0yXQS4y4BvGf1JXOY94KLHJw5RQmTXu3ZV7OBl+z0+kt
	o=
X-Received: by 2002:a05:6a21:a383:b0:3c3:875d:c52f with SMTP id adf61e73a8af0-3c67d9b2b1cmr7194873637.10.1785134411895;
        Sun, 26 Jul 2026 23:40:11 -0700 (PDT)
Received: from localhost ([112.133.220.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e0f4a039asm23323684c88.9.2026.07.26.23.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 23:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 12:10:05 +0530
Message-Id: <DK95C0SCPDX3.28ORSCO088KJ9@gmail.com>
Cc: <l.s.r@web.de>, <gitster@pobox.com>
Subject: Re: [PATCH v2] utf8: use size_t for string width methods and callee
 sites.
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>, "Hardik Kumar"
 <hardikxk@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <DK8L6JM14UNS.16B15DIOFW1K5@gmail.com>
 <20260726195718.1914131-1-hardikxk@gmail.com>
 <DK8Y8F4650AW.1XN921ROZW70F@gmail.com>
In-Reply-To: <DK8Y8F4650AW.1XN921ROZW70F@gmail.com>

On Mon Jul 27, 2026 at 6:36 AM IST, Pablo Sabater wrote:

>>  				printf(" (%s%*s %10s",
>>  				       name, pad, "",
>>  				       format_time(ci.author_time,
>> @@ -668,7 +668,7 @@ static void find_alignment(struct blame_scoreboard *=
sb, int *option)
>>
>>  	for (e =3D sb->ent; e; e =3D e->next) {
>>  		struct blame_origin *suspect =3D e->suspect;
>> -		int num;
>> +		size_t num;
>
> Looking at how num is used, it is reused for multiple things:
> - strlen()
> - utf8_strwidth()
> - line-number sums
>
> The longest_* variables we compare num against are still int.
>
> Can we split num into different variables?
>
I think it would be better to just cast the return of `utf8_strwidth` to
int instead when assigning it num.

>>
>>  		skip_prefix(it->refname, "refs/heads/", &desc);
>>  		skip_prefix(it->refname, "refs/remotes/", &desc);
>> diff --git a/builtin/repo.c b/builtin/repo.c
>> index 84e012f..47b9191 100644
>> --- a/builtin/repo.c
>> +++ b/builtin/repo.c
>> @@ -367,7 +367,7 @@ static void stats_table_vaddf(struct stats_table *ta=
ble,
>>  	struct strbuf buf =3D STRBUF_INIT;
>>  	struct string_list_item *item;
>>  	char *formatted_name;
>> -	int name_width;
>> +	size_t name_width;

> Same as above:
>
>   if (name_width > table->name_col_width)
>
> I think that these three fields can be promoted safely
>
>   struct stats_table {
> 	  [snip]
>
> 	  int name_col_width;
> 	  int value_col_width;
> 	  int unit_col_width;
>   };
>
> but check every use of them afterwards for code that still expects an
> int.
Changes to the struct field types might generate more signed unsigned
warnings leading to changes to fix things which might just not be
necessary for this. There probably won't be a use case requiring a very
high number for col_width.

>>
>>  	strbuf_vaddf(&buf, format, ap);
>>  	formatted_name =3D strbuf_detach(&buf, NULL);
>> @@ -387,12 +387,12 @@ static void stats_table_vaddf(struct stats_table *=
table,
>>  		string_list_append_nodup(&table->annotations, strbuf_detach(&buf, NUL=
L));
>>  	}
>>  	if (entry->value) {
>> -		int value_width =3D utf8_strwidth(entry->value);
>> +		size_t value_width =3D utf8_strwidth(entry->value);
>
> I feel this one is partially my fault, I wrote these as example output
> of the grep I sent last reroll. But they still need to be checked:
>
>>  		if (value_width > table->value_col_width)
>
> We are comparing size_t > int.
>
>>  			table->value_col_width =3D value_width;
>
> We are narrowing size_t to int.
>
>>  	}
>>  	if (entry->unit) {
>> -		int unit_width =3D utf8_strwidth(entry->unit);
>> +		size_t unit_width =3D utf8_strwidth(entry->unit);
>>  		if (unit_width > table->unit_col_width)
>>  			table->unit_col_width =3D unit_width;
>>  	}
>> @@ -582,8 +582,8 @@ static void stats_table_print_structure(const struct=
 stats_table *table)
>>  {
>>  	const char *name_col_title =3D _("Repository structure");
>>  	const char *value_col_title =3D _("Value");
>> -	int title_name_width =3D utf8_strwidth(name_col_title);
>> -	int title_value_width =3D utf8_strwidth(value_col_title);
>> +	size_t title_name_width =3D utf8_strwidth(name_col_title);
>> +	size_t title_value_width =3D utf8_strwidth(value_col_title);
>
> Same problem, these are compared against int *_col_width locals,
> and:
>   value_col_width =3D title_value_width - unit_col_width
>
> below the context now mixes size_t and int. Promoting the struct fields
> as suggested above fixes all of this at once.
Otherwise keeping these as int like before and casting the returns where
necessary also works in this case.

>>  	else
>>  		width =3D options->stat_width ? options->stat_width : 80;
>>  	number_width =3D decimal_width(max_change) > number_width ?
>> @@ -3123,7 +3124,7 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
>>  			if (slash)
>>  				name =3D slash;
>>  		}
>> -		padding =3D len - utf8_strwidth(name);
>> +		padding =3D len - cast_size_t_to_int(utf8_strwidth(name));
>>  		if (padding < 0)
>>  			padding =3D 0;
>
> The cast doesn't work here because len is also size_t. We could do this
> to be sure that there will be no problems:
>
> 	size_t name_disp =3D utf8_strwidth(name);
> 	if (name_disp > len)
> 		padding =3D 0;
> 	else
> 		padding =3D cast_size_t_to_int(len - name_disp);
>
Changing len back to int resolves this as well as the previous one.

>>
>> diff --git a/gettext.c b/gettext.c
>> index 8d08a61..4d5d05e 100644
>> --- a/gettext.c
>> +++ b/gettext.c
>> @@ -129,7 +129,7 @@ void git_setup_gettext(void)
>>  }
>>
>>  /* return the number of columns of string 's' in current locale */
>> -int gettext_width(const char *s)
>> +size_t gettext_width(const char *s)
>>  {
>>  	static int is_utf8 =3D -1;
>>  	if (is_utf8 =3D=3D -1)
>> diff --git a/gettext.h b/gettext.h
>> index 484cafa..f161a21 100644
>> --- a/gettext.h
>> +++ b/gettext.h
>> @@ -31,7 +31,7 @@
>>  #ifndef NO_GETTEXT
>>  extern int git_gettext_enabled;
>>  void git_setup_gettext(void);
>> -int gettext_width(const char *s);
>> +size_t gettext_width(const char *s);
>
> Careful, this is inside an #ifndef, if we change the signature here,
> the other branch must follow.
The implmentations returns either a `utf8_strwidth()` or `strlent()`
both of which would return a `size_t`. The function is only called in a
single place so I suppose casting it back to int where its called would
be better.

Thanks,
Hardik.
