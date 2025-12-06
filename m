Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8E225775
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.59.185.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765046906; cv=none; b=u/vXPGjBz7khzUrfgscH91uTbAItKNS68wVbcQelDqYzS0W6eu4lS7iEmAZELkvc2JFst/8xE62YGuiercpl1udfOwa4pSED5NVYfjsJDf3hZlpXFy7BhbVzcjgaV4gEXQnb4Hq0wuOOmg6TGVXCQDPAWHZRJyIADIzDDGEFj7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765046906; c=relaxed/simple;
	bh=ZAQxlJBk86LGZY86m0+TF3KtPgy0hMgBlxZTFOmYjMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C49Y0+MfzztsJr3S62jHgXKSFMlhHhoS3kZz86pHAi+XgKZ7N2vxaGy8Ty/d2CZNFLSAvhuwWSQdwjo4TRha+7ii9V89QotQK78qtgtoZAwk0jCSjry9Wr1ih/ZGH7dn6mf/0+EUThkeEap8qVOfle7Em0W2+IfH/mrClrDVkJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openmail.cc; spf=pass smtp.mailfrom=openmail.cc; dkim=pass (1024-bit key) header.d=openmail.cc header.i=@openmail.cc header.b=rmAVf27U; arc=none smtp.client-ip=146.59.185.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openmail.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openmail.cc header.i=@openmail.cc header.b="rmAVf27U"
Received: (qmail 13270 invoked from network); 6 Dec 2025 18:48:16 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with SMTP; 6 Dec 2025 18:48:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:content-transfer-encoding:in-reply-to; s=2018; bh=ZAQxlJBk86LGZ
	Y86m0+TF3KtPgy0hMgBlxZTFOmYjMY=; b=rmAVf27UjfGjlb+0N+vcwA/V/dfpv
	R+6gwpAl/zS/M/9nxdkUdnSuhj4uVJI/vPU7AGy9sMtTuMPlOKvDkfW8kduAJ729
	gkulmp8ayDIodLJ+f5Xgg/JORuCeiSnz4FcWb83QYexNB3cqXRBOmOOdm6Is9ZLV
	/qf8KWzVePFbcc=
Received: (qmail 95106 invoked from network); 6 Dec 2025 12:48:15 -0600
Received: by simscan 1.4.0 ppid: 95091, pid: 95099, t: 0.0395s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (bWFuZGF5QG9wZW5tYWlsLmNj@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 6 Dec 2025 18:48:15 -0000
Date: Sat, 6 Dec 2025 19:47:07 +0100
From: Cedric Sodhi <manday@openmail.cc>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: Git for structured data
Message-ID: <aTR6Ky7Nq32uj4_5@air>
References: <aTMNdQ_NHTVPtwG8@air>
 <be503e5e-43e7-41e3-afbe-265cd3da0636@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be503e5e-43e7-41e3-afbe-265cd3da0636@web.de>

On Sat, Dec 06, 2025 at 05:27:11PM +0100, René Scharfe wrote:
> Did you consider Data Version Control (https://dvc.org/) or Dolt
> (https://github.com/dolthub/dolt)?  Not a recommendation, since I
> haven't used them myself, but they match your description and call
> themselves "Git for data".
> 
> René

Hello and thank you for the two suggestions. I've read up on them and came to the following understanding. But first, I would like to mention that by "data" that needs to be versioned, I was not referring to binary (opaque) data, but rather exactly the type of data which Git currently manages ("source code", in a sense); but in a structured form. Think text or sourcecode fragments in an SQL database.

DVC, although different, seems to be similar to GitLFS and its focus on managing large, opaque data (binary blobs) as opposed to small, transparent data (textfiles). Essentially, it is meant to overcome Git's lack of performance with large files. I therefore think that it does not match my goal.

Dolt appears to fit the functional description. But while it expose a Git-like CLI, it seems to be neither based on Git, nor derived from it. Also, its software architecture is largely monolithic as it bundles its own SQL server, which is makes two-fold dependend on foreign code (Git for the interface, SQL for the database).

Cedric
