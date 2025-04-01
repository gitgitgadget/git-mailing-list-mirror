Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A5189F56
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743523815; cv=none; b=fpjLKOQyzXibsqROhU6B7IQmQ6yF++6fqmd1sZ5YvVaLEZrStjzkXPKznjriXMUuPAzH4gkhxipoTIzfNA+xq9VkZCNI2cUAATu5EENEOCROolMnScSoDZHA7CIuTdntb/YyVtAlFkCHQ0onQi2INaksON2ajmkIXu0XqP8pDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743523815; c=relaxed/simple;
	bh=OnzmMZW399t/hfwen9tdLD+7sQs2XGiwbX0LnK7sNB8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A90WQ5fsM8rTJRSCcEfYez2guJ3tMa8jjFAIUvkPyeaRpADpW7duB/HlwAGyNAumoeySlTOPIg3oj/jEaDZU13c33tzqzmy1du2Z54tPib8FwSXt32cQ8JYUQ+Kw9+Q4cM6a6KxYHgwbQY6R1iFLGp6iT31YcN6TfzPPPhtpgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=e5znVQyS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="e5znVQyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743523810; x=1744128610;
	i=johannes.schindelin@gmx.de;
	bh=AQsRY/3UVE/pb7qrAnjQ+cKebBiWtW/l1C8lBtek8Xs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e5znVQySwFEE/mNmxGN0JrJLAZE89qNZ1eutWZF/fSv80mMYFn2x7fuZKjK7CHz/
	 cog9+quIibPcMv+2nClkvLdasYLH2vuIsAsFnris0dN2K86iV92hPbXle60yqtMEn
	 FUPEjlmwoe5ZxCwvzpYeJX0KvehvQTB1KHDoVa78ewnq8OtvcZKLIY9zcX0DSIZoi
	 Hhi3XJFJe+wZyxQK+sokzKzQSpsW/ifFSBlJB7rwIVfGyLfP5gZdO20ZxwgrZP86R
	 8nkjFJ9qv23Hap2e9Qk5xKOnSWOrTxQu43HyrbmIFMEL15xMP+0hBFKPFsiYTqpXy
	 m6QhS/xsIiSZQxd4Qw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDj4-1to7KO1fIs-00CoJJ; Tue, 01
 Apr 2025 18:10:10 +0200
Date: Tue, 1 Apr 2025 18:10:09 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Mark Levedahl <mlevedahl@gmail.com>
cc: j6t@kdbg.org, git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] gitk: override PATH search only on Windows
In-Reply-To: <20250401030102.297272-1-mlevedahl@gmail.com>
Message-ID: <3c42af3d-556f-9593-b715-ea689d7b508c@gmx.de>
References: <5b09f1c2-be58-43a2-9908-7243b5207251@gmail.com> <20250401030102.297272-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FviDzqyssbGy2437xbiZXbZY/QjtGkbjraQsn/o4lLnDGcdXSLZ
 2MffKOWW2+jCuWYq665kWmV+j+vxdlVoOAnSbxZnqNbi68ODqM1Y2t9OG7VhS++N2WmGWq1
 f4TKMXKQw7DmAg/0hsHVGJjUdmavVv3UkH9VKbTrU/070aCDih11ZsoKmcsiEAjrJYIEfy7
 xzrnUm7e80Z8ynfpHpKuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9js3VkGdChQ=;jzM7eBX1A4cnsvAb3Y3wanVQ82D
 OGcxU8sQ8txK0mXLGssFhmjEn/C3dbBl+8s1mj1zWxGn6XYf/mBEn8VaQAOUIxi77OlIozg+6
 6+kOZ7LJjUOXKhUlw9RnO/JMBLLbywEJGSZCbWv3NwM+j9Vd6tThRAxrWf+FQ9lUCTQouQCQ2
 uv4COziExk3BYoQQBaBQxZNrv0Qu/egK7FANVkQWxZTS/k4vgjSOh/zs3rXsES6dcT52hvuEc
 sQC+kxOgn2G/Rp25uxrBfS86UgD+L2043G3VcshY8YSTMvOP+HO9jZ4KV1oc+Wuouip+2HfOk
 5Ty+QTuqvM+11LY2ohi2SZ0TH0XR+xyutzX77IRkahpmbwd8w7pO6700x492i4yuTADpnaBFq
 NeIzt5ud3hI3tqPGVd0SPF+Jq5Kh/SH4x3Or80xvNhTHe6ODxUkBnxvrZWrs/sgP5Xfk0kHOR
 zh7SJxcOtxVmsBPYGE/qrftNvEhK11xjaJqFz6K2ztlIIdiRjURlyx08v7DFrRVFeScku9KYH
 Fk+Fmv6cvW8PK0hPOKOEezSt8spSJ5c9+jDaeu8u4oGG0v1dOzV6FD3nCbjzCnfesBoWi/BEr
 ssFTx3JRCzWebaW9r9XUnSAvM5KCN05yb4moqlGu/0h3M0LSyDGtD5ZdlQhkT2EwbmTn4RkUA
 PaJ0Hgg0M+pkfnhICYZ7hz72zaOgqEVrO5ziQNt/bv/BIFAiVue5gN/8wWJEVXFomKy/gCimh
 hwIuIqzS7kSBtgISjWNaPlDVCj+/GEDtNhvUxu92lKM5Jz+709reub6FaYktTXAIWhiqrTstU
 YzNEWThSeXXWaIY4RYE1FVlKmheKJuNu73Zv8ltdiRJ+DNSrL9efJzxHcJ5c92eJSl6VJ4TpS
 8hobTnXFGHhFHZcVV76bl8d4+wxfP6DCxOds7aTSSJ6VIglyJRhtV6frXhKlWS6NyDFU92W5J
 PbZxv+ctN+DER68uDdvrADNh+zygzscYEHarqCAjonZ+wFqcqmf+kGZOGF/XdyqoXQ5P0tb0C
 AAjf4ODGlamIyTMEWEFb4R7T2oQrhZ43olblC1BOssuGb9D8lYu208Ns5odhmF3zgvZLNRJCt
 BZrYEr4ccVOT5zLtXIH5AcdCdyxI3HvFhC/3sxhgxrunPaiE13hqvc9hexpMrPPXhmt/PXVIt
 0iESdFPJONsLyrQg3MV963BkodiqNgKCyxqN6RI54f1ROU1Dutzve29/1PkwdtMSMlTAbn6+p
 ucfe0RHJtoL3jd8W3V3GOCFWBnxhIn2lt247yb4eJzw/9w523lrvFE8jq/ApJqyKiuJTi77jY
 seq6iWic070es23JAqz8X5pcpuorfABtCpYY+Q2vLml6Du24+f0BXcbH7raGoi4pAZSQxsPs6
 7zscFiOfC8PjVcY2SO5bUCc/htRw8EQo9GSJWfWQlsALnRc7PEP2FBhqiEQ6E7cChCWBNFDpu
 GbsgIl9SdvFHs7l1CP+NDRB120nfC8/B4Alsz8uvjbby+tbb9
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, 31 Mar 2025, Mark Levedahl wrote:

> Restrict overrides of exec/open to Windows only, as
> the need for this is Tcl adding the current working directory
> to $PATH on Windows. Recent modifications to this render
> gitk unusable on Cygwin, isolating these overrides to Windows only
> both fixes that breakage andk reduces the liklihood of similar
> issues in the future.

I agree that this is the right thing to do, and apologize for the breakage
by copying the code from Git GUI to gitk and then contributing it _years_
later without double-checking whether it is still needed for Cygwin.

> patch summary:
> 	1 - modifies the existing code to restrict the overrides
> 	   to Windows, restoring other platorms to native exec/open.
> 	2 - remove now superflous variable _search_exe.
> 	3 - fix the override code to avoid path search given a
> 	    relative path like foo/bar.
>
> ---
> Changes since v1 - fixed commit ID reference for git-gui, otherwise
>                    improved commit message in patch 1.
> 		   Added patches 2 and 3.
>
> Mark Levedahl (3):
>   gitk: override $PATH search only on Windows

I really wish that the reviewing process offered better tools than a
fixed diff for this patch; Inspecting it with `-w` would probably make it
much more obvious what it does (and make it substantially easier to verify
that it does not do anything inadvertently).

In any case, these patches look good to me, thank you for working on them
so carefully.

Ciao,
Johannes

>   gitk: _search_exe is no longer needed
>   gitk: limit PATH search to bare executable names
>
>  gitk | 147 +++++++++++++++++++++++------------------------------------
>  1 file changed, 58 insertions(+), 89 deletions(-)
>
> --
> 2.49.0.99.31

I want that version. It probably has fixed all the bugs.
