Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C3605A1
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969437; cv=none; b=HL5lud7MuDD1fv79PGPeqdd1Es+XbZKiDb6FGAjhqdOOGRD/BDjFUvTWL5ROOr0L33QHfEgP4aJwhkbb71VCpIE+tyEOjFpoIbiW9niM5SQquoOnVJi+qAUYFQw8ozzihwU/8m3Wu9kzvEQQPq247K8AOJiyyqYOOMKRdF/mAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969437; c=relaxed/simple;
	bh=WQT9VDO6kdyHHqhKcQiUsQUH06POHrCd4zFisuVAmPY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YbUVd2x3fMS4AwI6S7ZcnTfofETJ5Nq2B0dqiXG5Pj+hze6b8sjqAfgi6nmRiezbM0ZrEl0KOOvMLq4ou7UpkH4m1vz9Lyt+vy/j5qxSXznbpWKu2BMHLt+JjX+DYMfGgulvUJk8T6MF0ufrxS6YLmwZBBL5tYcLR5jGMlSvcQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8E4m86F; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8E4m86F"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso3362355276.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 09:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708969435; x=1709574235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKqINgIa4kAH9OxLL8crwNEFjT3CQ71Q9X4oAJ7xIzo=;
        b=W8E4m86FxJofkgZwka7qk9erhahbnHL1T48qQwCl8CSqILOceqQZZGDkZKFK8roPP6
         OJLmrpw8aTu8OQALu6sv0SnWO1nOgSA1kWuV9eW/5Vvp5dVRvrcShLnc0P7KsOIydMQA
         oPuwOvxyHDPSL9iI3hgAfZ4WaNT8xZZhMmjppGYo9fVKgsewiN2CKZC0cSJY8PkGrjLY
         pXOQG5wJLBeORuc/YlPbLbmN5/IPS/XrLboFc+x/fX2mYQll6PaXM3zCXdCrBl0i71XX
         CRyHjU25/ODfoeMRvqx0+Guq/HZlN1Nz5pEKYuBotGsLu8d5O+sqvVEyWpXB5KcRU6Ka
         uVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708969435; x=1709574235;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKqINgIa4kAH9OxLL8crwNEFjT3CQ71Q9X4oAJ7xIzo=;
        b=vvkBVZhvwH/0y+Rx/06MSokGC/b+wtpiDfS/0R5S1zgDP+jMbtfCynk4pB3QBZTV0/
         uFO723fxKJxp811xjYXMdF+0XwgnM+iyfPCv7/KCI2pbNTK82aXNp+KsVOhbwnvCTT/+
         moRs8sUjZl6ph7HeGyRbcS9G/Qd5pU4nvGnh7h4Tt+kou+DNFY4Sh1/YaELxWCVeXdcr
         MSSWO0MY8A4MjnPrvceQ6Gvc1kUcSsfMyMSGVE8H7UxJ0MdTwFVPJF7wXUvqoxfO2is4
         BSPv88ck6LQek6WtoCXjYBnjPFhA1jQYSq16Ly38km4cxjOX37n9+1Ges6kaHxp0J15r
         gDAQ==
X-Gm-Message-State: AOJu0YxX1md45ImUHPro2V9AlG0CmmDFhC57HFRRdfFgmobq4CFcHXqt
	Fg1cpQR2NEAaenUoL6zTBsCl+DFBzHcqQ7KfmAcotMi7TCMDVUKl
X-Google-Smtp-Source: AGHT+IGOj+KQN7q4Ijej3uSoTStIgsWozFM3me+l01HTQ9Pv94x8pjWdMKRMe2Ws7ikJ4i1cz55oOQ==
X-Received: by 2002:a25:c441:0:b0:dcc:8f97:9744 with SMTP id u62-20020a25c441000000b00dcc8f979744mr5641793ybf.43.1708969434873;
        Mon, 26 Feb 2024 09:43:54 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ff90:6db2:683e:23c:87ed? ([2606:6d00:11:ff90:6db2:683e:23c:87ed])
        by smtp.gmail.com with ESMTPSA id he40-20020a05622a602800b0042e7b0851acsm2001520qtb.48.2024.02.26.09.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:43:54 -0800 (PST)
Subject: Re: [PATCH v5 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
 Elijah Newren <newren@gmail.com>, Michael Lohmann <mial.lohmann@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Michael Lohmann <mi.al.lohmann@gmail.com>
References: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
 <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-2-af1ef2d9e44d@gmail.com>
 <xmqqa5nnj10v.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <d60ba27a-ac65-842a-9efe-a163480363d5@gmail.com>
Date: Mon, 26 Feb 2024 12:43:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqa5nnj10v.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2024-02-25 à 23:35, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>> +	for (i = 0; i < ARRAY_SIZE(other_head); i++)
>> +		if (!read_ref_full(other_head[i],
>> +				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>> +				oid, NULL)) {
>> +			if (is_null_oid(oid))
>> +				die(_("%s is a symbolic ref?"), other_head[i]);
>> +			return other_head[i];
>> +		}
>> +
>> +	die(_("--merge requires one of the pseudorefs MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD"));
>> +}
> 
> Just a minor nit, but reacting to recent "passive-aggressive"
> message change in another thread, perhaps we should stop asking a
> rhetorical question like the new message and instead state what we
> detected and what we consider is an error condition as a fact in
> them.
> 
> The last die() in the above helper function used to be such a
> rhetorical question "--merge without HEAD?" but now it reads much
> better.  The one about symbolic ref is new in this series, and we
> can avoid making it rhetorical from the get go.  Perhaps "%s exists
> but it is a symbolic ref" or something?

Ok, I can make that change. I agree we should maybe keep these rethorical 
questions to 'BUG' calls...

Thanks,
Philippe.
