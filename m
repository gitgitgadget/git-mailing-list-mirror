Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5D369204
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211901; cv=none; b=awzXIboU1qC6LhQYGBwQooIAMieIL8mMR0dAvpL9ePzdYEASh3F70A4TGNxt/rjfH/l7svBBHteS3DivY1FvKTlc0XTNMWvBU3cvn7msid8AKT3GstVGQFETDjK7UIASWqdpiVzMJBAGXd7kWTn8CLLtdmsPLg+XSEzS8Pdbf0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211901; c=relaxed/simple;
	bh=rGAYNeuIgnqJS+EynA+xkwNLDQuKTEFX3Kt1skp79Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rumI1vkOgnGl+jwbjVdu8PvWxwwJ2QSH/WpLvX3FVSOHO1tF9k/L6DreppDWvbZ8CN5Tm2mvhigwNjA+Gj4oPaBxvLA9FqS/TWXbYGojeOwvQYl28SpkVXS+bkLVXmp5FH93MWG0YJ2V9OzUPpa1e9OdYD6fwbojvEih1AyY7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iXayux+W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BLxUvp60; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iXayux+W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BLxUvp60"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E324EEC0099;
	Thu, 11 Jun 2026 17:04:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 17:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1781211898; x=1781298298; bh=jwIkPwo0twy6/fPO9+xkxwGxnvK6EgGg
	7lhlqmOVnhs=; b=iXayux+W8SoCGvs2RQYXlW6LCRgom1RnHy/qA59NrwZYpn0C
	ghv4LRO5dyS03trzdQw4ZEnQD90eBJQN8OG6ht0t14a21L3img6O/CT0Eu3w7wF9
	yNEdmqxKfs72NuHViYyy+7qf8OJX7X25JCTiGx34hS9sdeWXbrR+0a5it8kt0hHd
	5aa/dTltdrxTUdp4t3Xeza22iEdWY28zxTu+veSF2sSCFaWmAKwX51/rBRnCOL7n
	xCz56lXhl84fdjU2R57hs9flQ7792WkrkESHmehhlKieIpMY3m6K9dlxI0BQJFFw
	YkrgRZOkiC2kK7Udzn5MoCFyFfFLrW6bQLHghg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781211898; x=
	1781298298; bh=jwIkPwo0twy6/fPO9+xkxwGxnvK6EgGg7lhlqmOVnhs=; b=B
	LxUvp60Vmfcrtweye8dsVtqx4V6cTuFZBu7IWkjJexahXlCRI1iRp6STWmDCkoKT
	AmVoyx57pJ9wK2rvWz7/NFhoAArgdt824c0bYd1tllJIkTNEv0W8Oda41of9KyK9
	x1JVQ6pznT+4tELbJ7NrBbU7oc4PTAOyrSSqqfJMJIHfrzPdbSyefOE1Mbnyuulq
	JlwP4ClMdnwM2avmKriPUz1XwUuxf1Da7gJLeNHbUCCdhq9SODY7i0FA/j4BPYk1
	COdXN8fm++h4IRfrjm8rPWnAyo9GrWTMSF7nOiEf19L4ZOgLB9iiy6+UBtKIfibK
	fJ+NfgWhALdMYLOJfGPPQ==
X-ME-Sender: <xms:-iIraqNkjl2KNLGWAFfwDP2IkeN1VH1oir0H7ZBT0YYtNzdR_uMXcQ>
    <xme:-iIrau_q4ry3e8QtN3CAQzTRWfooPyihVFAUCKz0rrMSHmoDgmPOkKvhBPTn5MttY
    3bgBcN9Cs-zWh_urJ-cEglTOwOzcGqZbWd_q4uXhsG3fYCtJ902mQ>
X-ME-Received: <xmr:-iIrau63TVaF9C96PPcdQo1U9sxrSwHvhQ3RP7baBkh__7NxZhoA5HoyMRI8jSYjTWoJAnb1T36DelE2q5093xHrkrATtA2XTuSn6BnGbr3vy3DAo-yj2HM>
X-ME-Proxy-Cause: dmFkZTEXWNKQuUG1cgLpU7Ad1qjPqsUMLPXUJzcaSrhV6woD+9OKt8PYa2Ks5ajXU5Nk4t
    begG3XWYQ7/VM3pd2OXPizPHGVVcff6fJkPpk2Zd/Qnc8Z630Tcon4/nuxIcDPqJYCAHn7
    wmYe2TKWjbywI1dxLPGGeTGFNKvOaH8X2VTJpZCDLBtm3PBzS3t3/mU9qdex0dRIWmCGLZ
    w5XYWmDYWu/6XzwB3/bmq9R63EmTXw/bOXKJP/Oe+ygWKolPl5TBMHMZEKfeLa+rDlElYD
    ls+8zdG1YudgEcEmbvLeTrbNXflARJDhbJLYd6Mp4HDTqd8mxVtFOD0SN1dKS6lirxBzZF
    IG5eEj8M+AFXvm44IMNFfTcVDO/wLHYFDEpTrDlNCq8ogd3HdwjKi3eRmzw3BimzL0URy4
    ckqrwU7wenCQu5LJfP1l8eepF0UtFZ75G7q25b/ktb0dkfqiI73UKwSLgvLrZZiAS4bOsu
    03qlZ8nAHtFE8hXsgXCOBPgq6mcXnxJxygBPd/6LAsOcFFjwPZkhSfPlCmWVt4JWMJGidi
    slarmPymk3bZzw31XqD9xl4FvuJ0NWnO13qPmzeqpTVKVZA2wOYbUSlSzMdE0eUngZw5wz
    i4ZxlfenHDiig3kZgTYMIuvsGyAsutpWjxLRRWrIO5+Ro+tb2zR7HHewmE6w
X-ME-Proxy: <xmx:-iIral1tma2b_nuXI35NIopC38tSiQPvU4yEwEkyuf-jHB4l1-QurQ>
    <xmx:-iIralCcFyTvkT0l6zbwft8u3gJucYG2Gfy35m-Tp3_9Agoi7dwWvQ>
    <xmx:-iIran1Z1at1Y0bMbKk5psmnbvc-Yym_RFcziBcyJU8nKof6AaxSOg>
    <xmx:-iIravsaDpmfhT5q385tGipG8HrR1cO_oFuJNBd8r5RHwJFV8mVFTQ>
    <xmx:-iIrapywy9Ja-1XTUmbVCKotgdyjqe3K86Vnhl6YmeZCaBkIJL3sajx_>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 17:04:58 -0400 (EDT)
Date: Thu, 11 Jun 2026 17:04:56 -0400
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Matthew John Cheetham <mjcheetham@outlook.com>
Subject: t5563-simple-http-auth failures with v2.55.0-rc0
Message-ID: <20260611210456.XYfhytSL@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I tested the freshly-tagged 2.55.0-rc0 and noticed some new
failures on the in-progress Fedora 45 (AKA Rawhide) for
t5563.18 (http.emptyAuth=auto attempts Negotiate before
credential_fill) which was added in 9b1630b972 (t5563: add
tests for http.emptyAuth with Negotiate, 2026-04-16).

I notice that Fedora 44 (where the tests all pass) has
curl-8.18.0 while Fedora 45 has curl-8.21.0-rc2.  The
version of httpd is the same between them, FWIW.  I didn't
compare other package differences; it could be something
else entirely.

Here is the output from a failing test run:

--8<--
++ test_when_finished per_test_cleanup                                                                                                                                                                             
++ test 0 = 0                                                                                                                                                                                                      
++ test_cleanup=$'{ per_test_cleanup\n\t\t} || eval_ret=$?; :'                                                                                                                                                     
++ set_credential_reply get                                                                                                                                                                                        
+++ test -n ''                                                                                                                                                                                                     
++ local suffix=                                                                                                                                                                                                   
++ cat                                                                                                                                                                                                             
++ cat                                                                                                                                                                                                             
++ cat                                                                                                                                                                                                             
++ test_config_global credential.helper test-helper                                                                                                                                                                
++ test_when_finished 'test_unconfig --global '\''credential.helper'\'''                                                                                                                                           
++ test 0 = 0                                                                                                                                                                                                      
++ test_cleanup=$'{ test_unconfig --global \'credential.helper\'\n\t\t} || eval_ret=$?; { per_test_cleanup\n\t\t} || eval_ret=$?; :'                                                                               
++ git config --global credential.helper test-helper                                                                                                                                                               
++ GIT_TRACE_CURL='/builddir/build/BUILD/git-2.55.0_rc0-build/git-2.55.0.rc0/t/trash directory.t5563-simple-http-auth/trace-auto'                                                                                  
++ git -c http.emptyAuth=auto ls-remote http://127.0.0.1:5563/custom_auth/repo.git                                                                                                                                 
ddd63c907a6168e9992caee4ef0e0fa1139e4eb3        HEAD                                                                                                                                                               
ddd63c907a6168e9992caee4ef0e0fa1139e4eb3        refs/heads/master                                                                                                                                                  
ddd63c907a6168e9992caee4ef0e0fa1139e4eb3        refs/tags/foo                                                                                                                                                      
++ grep 'HTTP/[0-9.]* 401' '/builddir/build/BUILD/git-2.55.0_rc0-build/git-2.55.0.rc0/t/trash directory.t5563-simple-http-auth/trace-auto'                                                                         
++ test_line_count = 3 actual_401s                                                                                                                                                                                 
++ test 3 '!=' 3                                                                                                                                                                                                   
+++ wc -l                                                                                                                                                                                                          
++ test 2 = 3                                                                                                                                                                                                      
++ echo 'test_line_count: line count for actual_401s != 3'                                                                                                                                                         
test_line_count: line count for actual_401s != 3                                                                                                                                                                   
++ cat actual_401s                                                                                                                                                                                                 
<= Recv header: HTTP/1.1 401 Authorization Required                                                                                                                                                                
<= Recv header: HTTP/1.1 401 Authorization Required                                                                                                                                                                
++ return 1                                                                                                                                                                                                        
error: last command exited with $?=1                                                                                                                                                                               
not ok 18 - http.emptyAuth=auto attempts Negotiate before credential_fill                                                                                                                                          
--8<--

And a diff of the trace-auto from Fedora 44 and 45 via
./t5563-simple-http-auth.sh -dix --run='-18' (with the
sending port normalized to 44444 to reduce the noise):

--- /dev/fd/63	2026-06-11 16:51:05.852135692 -0400
+++ /dev/fd/62	2026-06-11 16:51:05.853135711 -0400
@@ -23,6 +23,7 @@
 <= Recv header:
 <= Recv data, 0000000000 bytes (0x00000000)
 == Info: shutting down connection #0
+== Info: Could not find host 127.0.0.1 in the .netrc file; using defaults
 == Info: NTLM-proxy picked AND auth done set, clear picked
 == Info: Hostname 127.0.0.1 was found in DNS cache
 == Info:   Trying 127.0.0.1:5563...
@@ -47,37 +48,8 @@
 == Info: no chunk, no close, no size. Assume close to signal end
 <= Recv header, 0000000001 bytes (0x00000001)
 <= Recv header:
-== Info: shutting down connection #1
-== Info: Issue another request to this URL: 'http://127.0.0.1:5563/custom_auth/repo.git/info/refs?service=git-upload-pack'
-== Info: NTLM-proxy picked AND auth done set, clear picked
-== Info: Hostname 127.0.0.1 was found in DNS cache
-== Info:   Trying 127.0.0.1:5563...
-== Info: Established connection to 127.0.0.1 (127.0.0.1 port 5563) from 127.0.0.1 port 44444
-== Info: using HTTP/1.x
-== Info: gss_init_sec_context() failed: No credentials were supplied, or the credentials were unavailable or inaccessible. SPNEGO cannot find mechanisms to negotiate. 
-== Info: Server auth using Negotiate with user ''
-=> Send header, 0000000214 bytes (0x000000d6)
-=> Send header: GET /custom_auth/repo.git/info/refs?service=git-upload-pack HTTP/1.1
-=> Send header: Host: 127.0.0.1:5563
-=> Send header: User-Agent: git/2.55.0.rc0
-=> Send header: Accept: */*
-=> Send header: Accept-Encoding: deflate, gzip, br
-=> Send header: Pragma: no-cache
-=> Send header: Git-Protocol: version=2
-=> Send header:
-== Info: Request completely sent off
-<= Recv header, 0000000036 bytes (0x00000024)
-<= Recv header: HTTP/1.1 401 Authorization Required
-== Info: gss_init_sec_context() failed: No credentials were supplied, or the credentials were unavailable or inaccessible. SPNEGO cannot find mechanisms to negotiate. 
-<= Recv header, 0000000028 bytes (0x0000001c)
-<= Recv header: WWW-Authenticate: Negotiate
-<= Recv header, 0000000044 bytes (0x0000002c)
-<= Recv header: WWW-Authenticate: Basic realm="example.com"
-== Info: no chunk, no close, no size. Assume close to signal end
-<= Recv header, 0000000001 bytes (0x00000001)
-<= Recv header:
 <= Recv data, 0000000000 bytes (0x00000000)
-== Info: shutting down connection #2
+== Info: shutting down connection #1
 == Info: NTLM-proxy picked AND auth done set, clear picked
 == Info: Hostname 127.0.0.1 was found in DNS cache
 == Info:   Trying 127.0.0.1:5563...
@@ -113,7 +85,7 @@
 <= Recv data: orn.0020fetch=shallow wait-for-done.0012server-option.0017ob
 <= Recv data: ject-format=sha1.0000
 <= Recv data, 0000000000 bytes (0x00000000)
-== Info: shutting down connection #3
+== Info: shutting down connection #2
 == Info: NTLM-proxy picked AND auth done set, clear picked
 == Info: Hostname 127.0.0.1 was found in DNS cache
 == Info:   Trying 127.0.0.1:5563...
@@ -154,4 +126,4 @@
 <= Recv data: 9e4eb3 refs/heads/master.003bddd63c907a6168e9992caee4ef0e0fa
 <= Recv data: 1139e4eb3 refs/tags/foo.0000
 <= Recv data, 0000000000 bytes (0x00000000)
-== Info: shutting down connection #4
+== Info: shutting down connection #3

The absence of one of the requests stands out.  Anyone
familiar with this area have suggestions for how to further
debug it?  It should reproduce easily in a Fedora 45
container, if anyone wants to poke at it more directly.

Thanks,

-- 
Todd
