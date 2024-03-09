Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836C111E
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710007264; cv=none; b=Kv2xazAHU5JrBsOnfPOd5ktlxkHkHkLd+05IBHZzh9ikxv+4Ol3+qCIwRfsL8Mz73hicl3u6ONrlLoeQSl+nHwNeQy84hC1JVDXGj3vgPIP6ZGv3jqIG3eVea77y4TUBJHJFyw0+uVfI3Ejq6HWytlH45g0bpKztLdmMAo+9OqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710007264; c=relaxed/simple;
	bh=mHFdchMh5TWrRBpbaX/gAJcWwHhkEId6m4W3H1w1IsE=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AxDOoMRvnkXUkqO63zhHsW+xTFsUEqe3TPUspS44spKKKvbb/CfUNo1mt2vyVAoLXuD+KESjfGmtW0CeY42R1TxhATdKucW5wwhzMb5d9EztCcjDjYtLntXxq55e//RbYqJ71BOVKyVh7L/0c6ea9ItBlYFLB0Eh+pbte9KUeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5GRgLke; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5GRgLke"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-787edfea5adso122602185a.2
        for <git@vger.kernel.org>; Sat, 09 Mar 2024 10:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710007261; x=1710612061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9qlkx9hyi40VtZmZ3WfhZtkWQG+OSc+iWSU3hVvcdo=;
        b=G5GRgLkeyP/cFXwQdL29k/1H9QBOImyu8HjaUDj0nTDqlcexh6ZCRVvSrUUz2QqVHw
         HXqUKCeiAZn9BmB7dt+2t4Q9Qe6FgMrUOglZsa8ch16SpM9tqDss/0fY8Jmj50hK12HL
         zaCzcGFsJbulB5ZZJnD6CpZu7jtP5f/7eiYaKYpcOBBbhPOiz/MIcsHK2gCzrGmDfybp
         A/WoUJafXnUephNuqo4IqBLyHizIlNuYcYTEacol6Gp6Oeyc0A9araqmTkXtTKNKl8eg
         usGgxZKYr14YaQM+/rDW4ujFr2vPUOV00e29i6rk0rLy5Ceu0SLTEG2lVKgX53zEt9py
         lNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710007261; x=1710612061;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9qlkx9hyi40VtZmZ3WfhZtkWQG+OSc+iWSU3hVvcdo=;
        b=aWhLoQe3rHqRshF7aZvmqF7SCUi7iKngKF6OB9kLivpdmqjaAwJ5zI2vMD29xdODUL
         W/fDHZO6fv90uR/p7uZHcnAThDJvFjSWGnRl1fjaysY71PYq/I3eKfG0bO7e7+4PDv0e
         8RGqdPduc1zoCuVxF9P/CcmKLpwd8RRzxHiRcUIapXlJhBgiytl0Yhe9H3KNFu5xXQ12
         cesMqnubLYwWDa/6NN9nfo1GyPNbhu8PMCnZMo0TFMEkCbea78Rjv1H7ZVjCer9gavD0
         HiFD7aas9MFQ7TjaOJpi1w0r8IA+OK4FRp9U+/2dG9f7huMF0PfxKJ8xZY4Q1FrvA4vK
         VAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYrA4i33OkO/CJskOZysnfu4ZVHflWLAg4FbPLjYAuUQyvMC5YAO9eXue/Zpj2BT5C0qIdxaqdTfBoMpgBsGMNoMXI
X-Gm-Message-State: AOJu0YxLa2nwdZJTt94Bqt1XLeCNtaPmcXz63xDuv6ZXwrnjpcUs1Tax
	n+IU4nYH2SbrWHg+MuUTLxdq8U2OFFdHLBNNXJYkgGmR3ot6Yb83aeDukkI5
X-Google-Smtp-Source: AGHT+IGyQgnf/0Z4pNT+eP0DYYKqjIwDFIs/1uBxvHVuMbzZjG3Isz0JGvJylrL3fCfwK5oYOM7KjQ==
X-Received: by 2002:a05:620a:5793:b0:788:33c5:b7b7 with SMTP id wk19-20020a05620a579300b0078833c5b7b7mr2867624qkn.26.1710007261383;
        Sat, 09 Mar 2024 10:01:01 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ff90:b1b9:ff9c:b8e:3049? ([2606:6d00:11:ff90:b1b9:ff9c:b8e:3049])
        by smtp.gmail.com with ESMTPSA id xx23-20020a05620a5d9700b007881e40ce0bsm1125472qkn.83.2024.03.09.10.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 10:01:01 -0800 (PST)
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
To: phillip.wood@dunelm.org.uk,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <3df4790a-7ee1-4c72-a3da-ba8a48d546b8@gmail.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <d83c271b-04c1-f3fc-d922-76f73ac2031a@gmail.com>
Date: Sat, 9 Mar 2024 13:01:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3df4790a-7ee1-4c72-a3da-ba8a48d546b8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Phillip,

Le 2024-03-04 à 05:12, Phillip Wood a écrit :
> Hi Philippe
> 
> On 02/03/2024 16:18, Philippe Blain via GitGitGadget wrote:
> 
> It would also be good to update the "rebase --apply" implementation to respect this advice config to be consistent with "rebase --merge".
Yes, this is a good idea. This would take care of 'git am' at the same time
since both are implemented in builtin/am.c::die_user_resolve.

Thanks,
Philippe.
