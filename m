Received: from fallback2.i.mail.ru (fallback2.i.mail.ru [79.137.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E533CF4
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466917; cv=none; b=UQOiwYe1J/qxJ0SxFT4QoFqhP7liShgFMtHhaIriXdcpYnvbc925GCLxG/YlEgzZ6v+z0T3uukn/Nfb5jw2CJMCKXA4lJpXV4hUw36J1lHjmXRWJ1+rnnGH5ScC0FNrOZil/9jDq0RK/Bt/34dnidrcUdoiuGqLqFYcio40v8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466917; c=relaxed/simple;
	bh=/WjeK+zPm7vtRTy144dOPUk+K1fHdwZxz80jfESMtaM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAh5XWyEOwwCQ1rVoyZ9XvmW8M6DqOYnyrKww3XrgrhnCoYqwJVNMxENUgRKKI73Y2i+LLWefldGBiWSU+0YZs2SRKfrBQNrMsrsZYHmnGJ8GPD6HXKKgV/gEunJViY3kr1bo/gQiH4KtDNLBsJO64n4vLOvHGl3XSDONux8JmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=iMLkAxMa; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=mmcUZfbp; arc=none smtp.client-ip=79.137.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="iMLkAxMa";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="mmcUZfbp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=iODF+yqkarXgRkGQ4A8W0Y1UgtAQBcvrv9sVX/I0wL4=;
	t=1707466912;x=1707556912; 
	b=iMLkAxMaw03gpx78w+tN7uVtJIcPcWloPF7RwbuuG+NncB8kZ0MTmcYJGSk2FvvRHclmBGYRIA1FZL4mrfDZWhtHE+xWg0GDhODlDTfCvisBJ2fgV/aVb5jPI9oRBF8RqOJMdsinwc+IV69hMD2vyIuBeXr5TNxwDlO2YSwbnu8=;
Received: from [10.12.4.16] (port=40340 helo=smtp47.i.mail.ru)
	by fallback2.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1rYM8m-00D1Yd-3S
	for git@vger.kernel.org; Fri, 09 Feb 2024 11:21:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=iODF+yqkarXgRkGQ4A8W0Y1UgtAQBcvrv9sVX/I0wL4=; t=1707466904; x=1707556904; 
	b=mmcUZfbpqJt5Km/zrVBfXE2udUN5iuKdaSBUuZX+hC2JjDE5+QH0xhsgNNNEb0BBmHdhJFVu069
	sU3dmo9RGt8lhR7TnLO/seuO+f0cEB90we74akakW9KAawNp8QHxeCltnv30pcKo+djn2bimmQHas
	y4IoDkYQWOKFO4ylyv0=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1rYM8c-0000000DWiN-3NxK
	for git@vger.kernel.org; Fri, 09 Feb 2024 11:21:35 +0300
Date: Fri, 9 Feb 2024 11:21:33 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: Commit fails when no global email address is set even
 though --author is used
Message-ID: <20240209082133.jzldo5diog2fd4en@carbon>
Mail-Followup-To: "git@vger.kernel.org" <git@vger.kernel.org>
References: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
 <51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
 <60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD91FEFD63CE1B09916316E0C418293B113AB9044BC056ED5D000894C459B0CD1B900F72F70D5ACA1D73D241DDC9C51DED2093538AC161553387B800F9EC084592B092611B121F4B2B0
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE789066434B85BF7C7EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006378D7045943A292EC88638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87CC038F71190D7954AFF1B3376FF70732A3A9D8866708474CC7F00164DA146DAFE8445B8C89999728AA50765F7900637DCE3DBD6F8E38AFD389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8D2DCF9CF1F528DBCF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CAD74539164518AE503F1AB874ED890284AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3EAD86A1CE980672ABA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFE478A468B35FE7671DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE79E6B27D82EEA174F731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5C2F2A2E891CFF8965002B1117B3ED69617EDD12A97A5990EAD0703CEB2EF9A27823CB91A9FED034534781492E4B8EEAD9DB614F8F96CFA30BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D3452F7993FB7281BFDA51B42EA77EBA3FB877E7223FB93DC8B017DAF7A3A109AC89D37DFC9861904551D7E09C32AA3244CF6C2FB0923816E54459F46583F07963CB1091C103EB5EA76EA455F16B58544A2C99F59F2F009F0963871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt6itc0777ZqInc0rKhiOrw==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138DB13C9925C254BFC7FC47A557B39A39B08B49274FCAFD4F17B225377A301302A2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B46EA299E95BC82A782CFFFEF9892CBE782509CFD7B116BC46049FFFDB7839CE9E2038077D049FFA75AA60C6DB85FC50C9AF2E955390004958D8A7CB9907972E9F
X-7FA49CB5: 0D63561A33F958A5AED55EA3AEBDD8BE0F65F8F1C78F160DECEF05176D44EEE68941B15DA834481FA18204E546F3947CB4B51A2BAB7FBE05117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE791DAD9F922AA71188941B15DA834481F9449624AB7ADAF3735872C767BF85DA227C277FBC8AE2E8BAEFF4136F5E2B48575ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt6itc0777ZrPMTpVDkpEWA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Fri, Feb 09, 2024 at 07:43:01AM +0000, Marcus Tillmanns wrote:

> Uff, that’s a mean trap. Especially since there is no “--committer” option
> as far as I can see. Also the difference between the two error messages is
> just one (the first) word.
> 
> Maybe that could be made more obvious, especially if the user specifies
> “--author” already.

There's a way to specify the author and e-mail on the command-line during a
single invocation:

  git -c user.name=marcus -c user.email=user@example.com commit ...

This "-c" command-line option is explained in the "root" Git manual page
(run `git help git` for instance).

The reasoning behind having different author and committer is that Git has
been created to handle the development of Linux where most of the code flowed
(and still does, I presume) in in the form of patches sent to a set of mailing
lists, so the person creating a Git commit out of such a patch in most cases
not the person who has authored the change introduced by the patch (the
author).

Also note that you do not have to set the name and e-mail globally: Git has
three levels of configuration, one of which is "local" meaning it's stored in
the repository's metadata. So you can basically run

  git config --local --add user.name marcus

to have this setting apply only to the repository which you "are in"
currently. This value will override any "global" (per-user) settings and any
"system" settings.

