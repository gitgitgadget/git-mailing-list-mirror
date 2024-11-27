Received: from zucker.schokokeks.org (zucker.schokokeks.org [178.63.68.96])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA89200B95
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.68.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732741059; cv=none; b=ISVO2xxFHn/Yc4KgbDGurXagnHxnvNscB/+LYjMpLqiZlZ96PtC9TYNEuYlzZuIP4Ksj78qqllAuw17Dd5BRszYPStNWpI9hD86gF5nyXiQsWEekrThWaJ2ZoSDJNhDNLkDL7SLUg3MOUzW6RcsLB5YaeSbSIw7xA/JVfESsU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732741059; c=relaxed/simple;
	bh=lqMeLKQEfzq1UrK4H1MWa9c15gACN1gbi8FXVVUtQX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=FHnoSF8K3O5ykK+W1tWUHgz8ZP4RlsluYUn6xtcrXDau7hZ24ShuiJ0imuoAUNriS8RWEC+ncmXm21y8QTWcf85COIm5WgGrSlzQp1uhL+arv58DeR8uHzKBZATJ7OFiV6azmdHzy+GDQD7POcqWcGggyF+EGKCQHk+tqpqDOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=das-werkstatt.com; spf=fail smtp.mailfrom=das-werkstatt.com; arc=none smtp.client-ip=178.63.68.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=das-werkstatt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=das-werkstatt.com
Message-ID: <f58d0ca9-305f-50e5-83f7-7939d310b8fc@das-werkstatt.com>
Date: Wed, 27 Nov 2024 21:52:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: git support for "xattrs" (extended filesystem attributes)?
Content-Language: en-US
To: "brian m. carlson" <sandals@crustytoothpaste.net>
References: <5b4c09a9-64bb-e672-e604-120563fc1ad6@das-werkstatt.com>
 <Z0Z2DVuR2PiN-oxy@tapette.crustytoothpaste.net>
Cc: git@vger.kernel.org
From: "Peter B." <pb@das-werkstatt.com>
In-Reply-To: <Z0Z2DVuR2PiN-oxy@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 02:29, brian m. carlson wrote:
> [...] There's a Go-based version[1] which does support storing
> xattrs.  Again, you can use a `post-checkout` hook here.
>
> Since mtree is a key-value format, you can also extend the value with
> other data.  I use a similar format in my dotfiles to specify install
> location, for instance, so I recommend this as a good way to store this
> data.

I just installed gomtree, and read my xattrs: looks very promising!
Thank you for the suggestion. :)

I'll read up on "post-checkout hooks" to see how I can integrate this in 
my git setup.


In case anyone's curious, here's an example of gomtree's output text for 
a file annotated using `yt-dlp --xattr`:

```
Universal\040Sequence\040\13320vPbH6UWIc].mp4 
xattr.user.xdg.referrer.url=aHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/dj0yMHZQYkg2VVdJYw== 
xattr.user.dublincore.title=VW5pdmVyc2FsIFNlcXVlbmNl 
xattr.user.dublincore.date=MjAxNi0wOS0xNA== 
xattr.user.dublincore.contributor=Q29uc3BpcmFjeQ== 
xattr.user.dublincore.format=Mjk4IC0gMTI4MHg1NDAgKDcyMHA2MCkrMTQwIC0gYXVkaW8gb25seSAobWVkaXVtKQ== 
xattr.user.dublincore.description=VmlkZW8gcmVjb3JkaW5nIG9mIHRoZSBmaW5hbCB2ZXJzaW9uIG9mICJVbml2ZXJzYWwgU2VxdWVuY2UiLCBhIDY0IEtCeXRlIHJlYWx0aW1lIGRlbW8gYnkgQ29uc3BpcmFjeS4gRmlyc3QgcHJlc2VudGVkIGF0IHRoZSBGdW5jdGlvbiAyMDE2IGRlbW9wYXJ0eSwgd2hlcmUgaXQgcmVhY2hlZCAxc3QgcGxhY2UuCgpEb3dubG9hZCB0aGUgcmVhbHRpbWUgdmVyc2lvbiBhbmQgc291bmR0cmFjayBhdApodHRwOi8vY29uc3BpcmFjeS5odS9yZWxlYXNlLzY0ay91bml2ZXJzYWxfc2VxdWVuY2UvCgpFbmdpbmUgY29kZSBhbmQgZWZmZWN0cyBieQpCT1lDCgpWaXN1YWxzIGFuZCBkaXJlY3Rpb24gYnkKWk9PTQoKU3ludGggYW5kIG11c2ljIGJ5CkdBUkdBSgoKaHR0cDovL3d3dy5jb25zcGlyYWN5Lmh1Cmh0dHA6Ly9mYWNlYm9vay5jb20vY29uc3BpcmFjeS5odQpodHRwOi8vdHdpdHRlci5jb20vY29uc3BpcmFjeWh1CgojY29uc3BpcmFjeSAjZGVtb3NjZW5lICM2NGsgI2ludHJvICNyZWFsdGltZSAjaHVuZ2FyeQ==
```

Values are base64-encoded.
Nice.



Regards,
Peter B.
