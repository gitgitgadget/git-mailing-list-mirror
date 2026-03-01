Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C945280338
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772380180; cv=none; b=O83ms08ojSmKgoH7K9DgvUTD2iZIacSe1gOm0hzm4//0s8f3qI/xDF789TSLnFQVlQ1plnv1JASvpMWRYam9k7uY+6S0ZLN5Xlfa12NQ8wDR4KrwPM0e6TQ6MJ1ARA2fCu+xk32QWfYZdYEpUz7KEqZlKOFxNm4qt0OMVsDeaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772380180; c=relaxed/simple;
	bh=pBJ0qrO9jZ+uSO9OEwjrgLD45MswmZ21sgMKNpEQiic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXgR2VyE5SwXGzTLKYG1MVLZv0Mm4OmENuh1LMiiHpMsGMq/UFsFNgsqlAVhdf4Rj7JiL8ZSIaa11nzj+XtxV9FdD+NMTtkLe7KYUSDpouPmno81DAphHeOn3KpFBdepkPsKR4QziCGKSk/SQob69lKn91R2xkKN74MIqy+p91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCbkB58H; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCbkB58H"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae4988e039so3108105ad.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 07:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772380178; x=1772984978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6saVPLDEyaxhwJw2bTsRgCpJuhDC1nFOZD+PdXRkfrY=;
        b=LCbkB58Ho9serjMHhlq0MVjxTo4AITTja2Z+f1fL8l8i6AyWSVMQpfoJGixChSKLnw
         eg9AX8GcWp8t32Ock6IyOvSIiOFxghCRQuKeS7uLKf8XXWJcOwOTUP5fatIr4OqkvjV7
         NV1pDd+dp2Zy+bDklc/LxNMHuznFzgUMB789ARsxBVCYdAT2S9RHO26sGc0+AteE7G+4
         jUrkdAtGIK+P5WtNLYx+OUC5NnfhBIhFIdH9B9TwRUQqOYd/nCbi9aNQ9TrdvvfSzqec
         +HBGJ89UBGXm2BmI8eeH+lfPKFjaT7dJgPc1gBGP75Zxy9kX42//S2JLkItOmZ5Ai58K
         B+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772380178; x=1772984978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6saVPLDEyaxhwJw2bTsRgCpJuhDC1nFOZD+PdXRkfrY=;
        b=XJo+KiqRy+9XlAkc00XNCsCYBXtVMnm4sViS4mBmKOuXesaFSPti20zGTFdS8XbIRb
         guN1QJJDIj2oDCsTHJZpIXyvMQsnBqriqShGckv1nLUSTEMs4l6znAig+Enq4iWB3mfZ
         dxxiEeK78Yno2fi0RhriPMCnSTbitbmPy1juCOl8dpXUl1tH3cxz82m5bSt6Eb/ItrEN
         27dU0B8lygmwwAP+qbndNV/Lncsp0uekF0TuO2cvBBSF0kuAmHoiUlEe/CRaH1xJzmDv
         AO4l6/qqhbeSKJVmzEFyYj9VVIqqSVP7f4aQDCuXJ+lU5BtHWc6Xl+WBb1v/Sc9V4UtT
         YWDg==
X-Gm-Message-State: AOJu0YwbrDlSdBVjx7vkYIdITRXfEX5GT3yFdsGj7y1nq57PGAnb5uzS
	3zNw/LQD9BsWlsVZBEh0ZMqLWYM4ULJOg5nHNLNWz5mrOxH5VJix1UNU336TnQ==
X-Gm-Gg: ATEYQzwkUtiRmPVKj0TCNBNGq9xVvuTKZTB1Gm50VNDbmC5ryXSyukIEGk/SSMPPnH4
	kstJ/VcM7k6VHCwp6Ay6JOdORBfh5boScoWLdZmYvFNYgpQC9VXcqcxgXPZ0obNFs/ddatvwmxd
	QA2yoQD1FxvWqyni3uSdzdqUJyIWtZHsu1j3b1oxyfpaxVuruKdMMlQUaVgy07ZixDMWPvf+UQZ
	V9QAufJKXpAhIeiT841JDFPm9rgaU1eKaZmmtlql1VrskpnCfrw2+OJ5n0fdC3XiFiBkwqkzkhV
	ur55w5o5YsIDss7T2q1vXrk84EAGHW/hgX02807IWLBg2Vt59o6yrh8LnhThKuJMhpyOntvxZXA
	Pk3TYs4Dz1EO81SiNh5Y+Ad2rjxZV0i98PyC3bhmFwU6JkO0h9BtnYk+TRnRqIZxpC3cpLT/AOE
	A7eKjzuotO/EaOplxG706glEcZ6GcEcLMBoSH+Ja9E/ZL5ioYm2vKLdw==
X-Received: by 2002:a17:903:3c6e:b0:2a0:d454:5372 with SMTP id d9443c01a7336-2ae2bad7ce6mr94155025ad.22.1772380178470;
        Sun, 01 Mar 2026 07:49:38 -0800 (PST)
Received: from Shreyansh-PC ([2401:4900:88eb:2b10:88fa:5af8:efaa:d5f8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d19559csm46428315ad.5.2026.03.01.07.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 07:49:38 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	bkkaracay@gmail.com,
	lucasseikioshiro@gmail.com
Subject: Re: [GSOC][PATCH 1/2] editor: make editor_program local to editor.c
Date: Sun,  1 Mar 2026 21:12:30 +0530
Message-ID: <20260301154905.13993-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aaQzlE2lsq4WfFxt@fedora>
References: <aaQzlE2lsq4WfFxt@fedora>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi Shreyansh,
>
> I am a GSoC applicant like you. I just wanted to leave my two cents
> here.
>
> On Sun, Mar 01, 2026 at 04:12:58PM +0530, Shreyansh Paliwal wrote:
> >+static char *editor_program;
> >+
> >+int set_editor_program(const char *var, const char *value)
> >+{
> >+	FREE_AND_NULL(editor_program);
> >+	return git_config_string(&editor_program, var, value);
> >+}
> >+
>
> While moving the global variable from 'environment.c' to 'editor.c'
> doesn't cause any behavior change, it still relies on global state.
>
> I think passing a 'struct repository' and using the 'repo_config_get*'
> helpers here might be a more robust approach. I know this means we would
> catch config errors later (right before the editor start up). However,
> since it doesn't seem like it would cause a data loss or serious issues,
> this behavioral change feels like a reasonable trade-off.
>
> Thanks again for the patches!

Hi Burak,

Thanks for the feedback on this, I appreciate you taking the time to look.

I did consider the approach you suggested. Currently, editor_program is
only used within editor.c, and it is I believe a process-wide setting rather
than something tied to a specific repository. Because of that, it did not
seem necessary to add it to struct repository or repo_settings at this stage.

More importantly, my intention for this was to keep original behavior as-is.
As noted in earlier discussions [1][2], maintaining early config validation
is important so that invalid core.editor values are caught early. Moving to
a repo-based lazy lookup would change that.

That said, I agree that there may be a better way to do this refactor,
so I'd be glad to hear more thoughts on this :)

Best,
Shreyansh

[1]- https://lore.kernel.org/git/1d43d1d0-bf6b-4806-834e-89f545fab766@gmail.com/
[2]- https://lore.kernel.org/git/xmqqpl63b2tm.fsf@gitster.g/
