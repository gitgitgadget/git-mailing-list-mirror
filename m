Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BBA305971
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097016; cv=none; b=RdjxkJDyVOumwerrxAIXlho+7U7K4E4vjji3DcQPFH9DsJGpYSX75Dkd6z1+SWRwHgbd+t6aYARMKZIulxdV/nnIWGV2mxUDtVBrnA1VzCJXITX4mvUXWS3ctp4NB1LlRI6+jN5M27UwAwc3YRmxGTHpjMeFhCFQCF4Q4IXzlAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097016; c=relaxed/simple;
	bh=1Ty0GFhj7nQ5Dzk8G88OLUMUcoYDcbY+yDqlOkq0I8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBtYs6ErZSRMiNsHt1EB8HKhPDXFKEoMHhfgvxevBaJAz1PVd3PrRV2gPxAn/9a59ZeiJzHWHjTyR/wrUwPE3WUGxpdJgcbg9nkeCRkKKlL8vPcslrmbjR4eXdNzW0JyhctsFrEWMEA+ubQY+UBZIYAEMOYbQ292mzUE74abSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9kiq7zi; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9kiq7zi"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b5e4fc9b4fso10447221cf.2
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 11:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757097013; x=1757701813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCngJoByNoAspaGfLn8Eq0vi2bFQ5U5QoVKvc2VOz6g=;
        b=k9kiq7zi81XFpS1GpT1JHTFWwn3LM3N87ssylSo2zXFD9NZnK6pdr90iV9zViJvyMx
         dClxTZgDSluHwhObL0+8SfyHpEQr5mimk7JFWkTWAKJ1nAFfDG3REL1aSbyK60uFXbWk
         GG1SoMj/w01FAtdBdyVv7X+x8kD1q8I93JSykv88OwKwvI/bQr4ND7iUQnON1b4EDmOc
         kG9WAjjXH8QxVs3U7V942VUHk1TPZKEc1PwOd0dgDGlIWaeSsuWbCfj6QccddWz0jTb7
         GM4J15noaA/XcMRZYg01CMY1F0MwW15v9SniRCSZ6bRV6TSN3BTcxyB7g7Q5Hs90uCpV
         hjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757097013; x=1757701813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCngJoByNoAspaGfLn8Eq0vi2bFQ5U5QoVKvc2VOz6g=;
        b=I+dooEvCNGioYRp0+KcYyvviamx9mBVGpF4yj6y/los9ciHzg1aEEvytshhiYMUaTB
         iccNKKhNMgGqqeoF9CH3jBri5AFxpaG/90ks6+gOd7EkznlUX5F85LEKI+pAjQfG6fnu
         Q4DqCgAw2TBmyJpFvlD6D6dbbitLeNQ6LykTu0l7UGIfF5h5cf6Y1MiopvbQ2OKjcgW9
         oPsu5wczdgES2wUHha7KjRXWq0Frost/G+3+xZWfXtJnvMDa4NNHDhNiBFwvcndiD86f
         nixcF5n6OFpOyTMW8+Nrs0II0tG4Fe6obRQ15MrAm0HEfAAogePPZ1eazlV2Rr8GVhJO
         9g6A==
X-Gm-Message-State: AOJu0YynZcONmj5sr98GZ0dkz+4ImnoQQUOQUyoJh0akg+V5tnFoazxg
	+bCd5GOPmp28CvOTyLyVfIawK49WKqw0PqLixLhgjSLXehT0AAri0rQIAHe97g==
X-Gm-Gg: ASbGncs/MvY+V9DpHkoiLz469xPDcmBrAcaTshxv/99dAZMZ7pFwn2Pl3ypsARpf9Vw
	vM8kiHgABG3r3ufHwSO/s+lj2lKQ9sbXQl4Q+qSlzZ5WQOXlYbCgshsx12n1ux/5sJnRVs4JSbr
	jKd4dX8GJOM3OM9ZFlPGsHTNiMhMOBA1b/aBL9cnpfwWQ/z+nnm/zURxK1ljnbEnM0Ke7jLkgBr
	HknOuh+T4bu7C0HBGUZ1rjRDNHdukfzQHHz5AiaMyzPUszfrDj1XUCfweGj4rYg7K/KQz2ndQPS
	DIDbKPoo0RXVPgyhC9jk7eri92iXEpzVr4fALJU/4CPJHRrTej1MJZqQE9iI2PfnrTMgd+DSKCS
	UKuOp5pL3wI8BmO0qC14b4HWctvKhXabj/1QTJu+jvkr+OQ==
X-Google-Smtp-Source: AGHT+IHYMEV86tVprakoKrjF6gJ5QGzDIeDzdQKP3jSGP8yC/hUPuObSTryaSIOU6UPltatQsGe6yA==
X-Received: by 2002:ac8:5f14:0:b0:4b3:1d29:6a68 with SMTP id d75a77b69052e-4b31dc8e3f8mr343531181cf.71.1757097012616;
        Fri, 05 Sep 2025 11:30:12 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f799b83sm51630571cf.45.2025.09.05.11.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 11:30:11 -0700 (PDT)
Message-ID: <cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>
Date: Fri, 5 Sep 2025 14:29:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <xmqq5xdx7qx4.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq5xdx7qx4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2025 7:12 PM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> commit graphs are currently stored on the object database level. This
>> doesn't really make much sense conceptually, given that commit graphs
>> are specific to one object source. Furthermore, with the upcoming
>> pluggable object database effort, an object source's backend may not
>> evene have a commit graph in the first place but store that information
>> in a different format altogether.
>>
>> This patch series prepares for that by moving the commit graph from
>> `struct object_database` into `struct odb_source`.
> 
> Hmph, I am finding the above hard to agree with at the conceptual
> level.  In some future, we may use multiple object stores in a
> single repository.  Perhaps we would be storing older parts of
> history in semi-online storage while newer parts are stored in
> readily available storage.  But the side data structure that allows
> us to quickly learn who are parents of one commit is without having
> to go to the object store in order to parse the actualy commit
> object can be stored for the entire history if we wanted to, or more
> recent part of the history but not limited to the "readily available
> storage" part.  IOW, where the boundary between the older and the
> newer parts of the history lies and which commits the commit graph
> covers should be pretty much independent.
> 
> So moving from object_database (i.e. the whole world) to individual
> odb_source (i.e. where one particular subset of the history is
> stored) feels like totally backwards to me.  Surely, a commit graph
> file may be defined over a set of packfiles and remaining loose
> object files, but it is not like an instance of the commit-graph
> file is tied to packfiles in the sense that it uses the index into
> some packfile instead of the actual object names to refer to
> commits, or anything like that (this is quite different from other
> files that are very specific to a single object store, like midx
> that is tied to the packfiles it describes).

This is an interesting aspect to things, where the commit-graph file
is a "structured cache" of certain commit information. It happens to
be located within the object stores (either local or in an alternate)
but is conceptually different in a few ways.

The biggest difference is that you can only open one commit-graph
(or chain of commit-graphs). Having multiple files across different
object stores will not accumulate additional context. Instead, we
have a "first one wins" approach.

This does seem to be something that you are attempting to change
by including the ability to load a commit-graph for each odb (and
closing them in sequence as we close a repo).

So in this sense, the commit-graph lives at the repository level,
not an object store level. When doing I/O to write or read a graph,
we use a specific object store at a time.

The other direction to consider is what context we have when we
interact with a commit-graph. We generally are parsing commits from
a repository or loading Bloom filter data during file history walks.
Each of these do not have a predictable nature of which object store
will "own" the commit we are inspecting, so it wouldn't make sense
to restrict things like odb_parse_commit() over repo_parse_commit().

With these thoughts in mind, I have these big-picture thoughts:

1. Patches 1-5 are great. Nice cleanups.

2. Some of Patch 6 is great, including having the I/O methods use
   an odb_source to help focus the specific location of the files
   being read or written. However, the movement of the struct into
   the odb_source makes less sense and should still exist at the
   object_database level.

Thanks,
-Stolee

