Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F735837E
	for <git@vger.kernel.org>; Tue, 12 May 2026 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571357; cv=none; b=FRl8aPM0hvJXgBApB2bwGIDPLEivd3/nRtvSIXzYfVy89oE3CxeTtqMrbDDwgFX1Vcbddsr5MsT08IhOCAcqXlHXTFdyK2bW8Oo7bmTUmTjVxVb/mvOBxBfYYzOLtWkkQuR4ITHpaMLMI3Snabt6tnCJ0ZOSiacYB0jj3iZaihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571357; c=relaxed/simple;
	bh=IW3ByqhMONAFaYZ6AYjZKgRP7LyZ2k1fBIEdOozuoow=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To; b=ZjywSW8FTnQKmJ8DbodFF0BkpaVBUN0d0fEQkt0I6MTRu9qB1/LXrL6O5z3NEHQ75mwTE+yAE6WtKG8FqtAzLRE4+31L9AZ2F2o1gTulLk0gPoSetA3wt+rXBkgFZUotTc3/l7MjazjmxbswDLQeaGuYM8IB1wDfLcqjZexkDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZhQm+t2h; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZhQm+t2h"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso59846165e9.1
        for <git@vger.kernel.org>; Tue, 12 May 2026 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778571350; x=1779176150; darn=vger.kernel.org;
        h=to:autocrypt:subject:from:content-language:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0BS0d+7KLUZc99Yk35zz3z30BhDTXZ3lDEyGeNqbNhg=;
        b=ZhQm+t2hNLi2eK1tCK+tw+irRx1KR3Mj/+XZVmEwiaNPeq9mDqSLOim0WZ08zziQaJ
         n+A/Nhn4+SWm3wIKlBhvnVTYGJH5fav5sohM30TN35Dp/0HOJoCMRdfopyudhtQGjeYh
         Qv7KFQpVtrAb/JRzqAqs1Js4prGBKfV7ESlQ3Yv19hbfHBdzHzXyNiiLf3OGokdw0XWp
         09CA0FXeE/UVGUFFm83lwRSz3Ba1L6DCi+IUScHbauGGlphwI1Lh897uOschF/jLqVZW
         OKgHROMBjTTICy2w1gNMuvg8usfvEc7iFHc2sOi2M9z1vMs5StgbvnThteB+uqzn69P5
         A7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571350; x=1779176150;
        h=to:autocrypt:subject:from:content-language:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BS0d+7KLUZc99Yk35zz3z30BhDTXZ3lDEyGeNqbNhg=;
        b=CQj65xWQrzAztJXmdehWmj5aJ8dlY64bwuby34OofoiOisWvFEyuVc3Bwat8D7CREu
         fsmzXruoYPgDCjz9HNRig4FToQTJWZyiOf6Z+A96TgxnkJgfU/YNUF7G9WRQktULjbCu
         i7T5bcR42L0nHDywoAws9EDhuY1SKrxz15Ir23r2PRcdF7jnyjTCH7pEpKYvjiqDWiTa
         RHYYhH0bjERyUuGs0jTTBqaGR2f0mMDPUimmol4LZH8X1rgeN/0RmT2DYbNBvJbJv5uQ
         3s9hL0o/GP4fkqFF81aRfUysoF5YB0uWuCul79aBsQ9TKHnxgEKgrp4+XE0Q2K3bfdZ0
         0fgA==
X-Gm-Message-State: AOJu0Yyiww3jvDgrL9s9rFshJmuPF85O2a7iQusavilT+1eX6rXx6trP
	qlp3cTaby+vdFxOjs69i8C/6T4IAyKqoRBdfH15c6bVFBmyBostEhu0Wlbgeo1l8VTXhl32/ybe
	4yyUYbRo=
X-Gm-Gg: Acq92OGr1DvWDCu/E0X5+qx7VR6/8jrLnOYIbarO5pKOFrBFk6AP81vHxUJAqXg6Qbl
	Hplg7oy7wRNrldEUb/pFwvkdYty+6mmffohdMfL86WUmd/l/klLxVWKQ1VBVC7JAmgmos4ulrTn
	3fwfupAkS/PXud2t8JzUmOuKvyUKI8dL3WdhXRMT53HEpJEvl/MHfuaXkYItUtSEB3kh+ECbj8z
	FnwKtTs/oCtZ88n+sTJwlSJqnr7EJibRvIlCY6P99GtF2wMA0tWjXyEMqtuook7xlDWiea0SMWp
	7U2+jjTtjLXhxuVlHB1JvukXyv37C9varfjzISayFa4aGArPuGkmD6c4f7O0aVEhHBU762r9h6+
	vN/nh/ripmXQBEwcIPA1hE1JCKiZ1K93tO3uc5nIE7pto8cJHQuL7wFkwXa0p1lH48spDNi0FN1
	PQpU+Bjxt0+31hQfv+TSoV6uZc+oQlUyqX6oC3
X-Received: by 2002:a05:600c:a118:b0:48a:58e1:6d02 with SMTP id 5b1f17b1804b1-48e51f35b3emr355117735e9.19.1778571350391;
        Tue, 12 May 2026 00:35:50 -0700 (PDT)
Received: from [192.168.1.211] ([185.19.1.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9053f690sm28632005e9.7.2026.05.12.00.35.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 00:35:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------scR6AWr0IUd80RR4fMrzjkil"
Message-ID: <6ae85515-9373-4c9e-90d2-5e4176590c5b@suse.com>
Date: Tue, 12 May 2026 09:35:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daniel Mach <daniel.mach@suse.com>
Subject: git clone fails when using --dissociate together with a reference
 repository that contains a commit-graph
Autocrypt: addr=dmach@suse.de; keydata=
 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
To: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------scR6AWr0IUd80RR4fMrzjkil
Content-Type: multipart/alternative;
 boundary="------------02OjlxH0FfQwap19xwjB00Im"

--------------02OjlxH0FfQwap19xwjB00Im
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I've stumbled upon a bug that the following command failed:

$ git clone <url> <dir> --reference <old-dir> --dissociate
fatal: unable to parse commit <SHA>
warning: Clone succeeded, but checkout failed.
You can inspect what was checked out with 'git status'
and retry with 'git restore --source=HEAD :/'

Omitting --dissociate fixed the error, but it wasn't clear to me what 
might be the root cause.

$ git --version
git version 2.54.0

With the help of AI I was able to create a reproducer (see the attached 
script).
I have verified that the reproducer works and also simplified it.

AI generated report (take it with a grain of salt):
* The Bug: During dissociation, Git correctly repacks objects and 
removes the objects/info/alternates file. However, the git clone process 
has already initialized its object store including the alternate's 
commit-graph.
   After dissociation, it fails to "forget" or reload the object store, 
leading to a crash when it tries to use the commit-graph (which refers 
to the now-unlinked alternate) to perform the initial checkout.
* Proof of state: As shown in the script output, a manual git checkout 
immediately after the failure succeeds, proving the repository is 
structurally sound but the clone process itself was in an inconsistent 
state.
* Workaround: Passing -c core.commitGraph=false to the clone command 
prevents the crash.

regards,
Daniel


--------------02OjlxH0FfQwap19xwjB00Im
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><font face="monospace">Hi,</font></p>
    <p><font face="monospace">I've stumbled upon a bug that the
        following command failed:</font></p>
    <p><font face="monospace">$ git clone &lt;url&gt; &lt;dir&gt;
        --reference &lt;old-dir&gt; --dissociate<br>
        <span style="color:#000000;background-color:#ffffff;">fatal:
          unable to parse commit &lt;SHA&gt;</span><br>
        <span style="color:#000000;background-color:#ffffff;">warning:
          Clone succeeded, but checkout failed.</span><span
          style="color:#000000;background-color:#ffffff;">
        </span><br>
        <span style="color:#000000;background-color:#ffffff;">You can
          inspect what was checked out with 'git status'</span><span
          style="color:#000000;background-color:#ffffff;">
        </span><br>
        <span style="color:#000000;background-color:#ffffff;">and retry
          with 'git restore --source=HEAD :/'</span><br>
        <span style="color:#000000;background-color:#ffffff;">
        </span><br>
        Omitting --dissociate fixed the error, but it wasn't clear to me
        what might be the root cause.</font></p>
    <p><span style="font-family:monospace"><span
          style="color:#000000;background-color:#ffffff;">$ git
          --version </span><span
          style="color:#000000;background-color:#ffffff;"> </span><br>
        <span style="color:#000000;background-color:#ffffff;">git
          version 2.54.0</span><br>
      </span><font face="monospace"><br>
      </font></p>
    <p><font face="monospace">With the help of AI I was able to create a
        reproducer (see the attached script).<br>
        I have </font><font face="monospace">verified that the
        reproducer works and also simplified it.</font></p>
    <p><font face="monospace">AI generated report (take it with a grain
        of salt):<br>
        * The Bug: During dissociation, Git correctly repacks objects
        and removes the objects/info/alternates file. However, the git
        clone process has already initialized its object store including
        the alternate's commit-graph.<br>
          After dissociation, it fails to "forget" or reload the object
        store, leading to a crash when it tries to use the commit-graph
        (which refers to the now-unlinked alternate) to perform the
        initial checkout.<br>
        * Proof of state: As shown in the script output, a manual git
        checkout immediately after the failure succeeds, proving the
        repository is structurally sound but the clone process itself
        was in an inconsistent state.<br>
        * Workaround: Passing -c core.commitGraph=false to the clone
        command prevents the crash.<br>
        <br>
      </font></p>
    <p><font face="monospace">regards,<br>
        Daniel</font></p>
    <p><font face="monospace"><br>
      </font></p>
  </body>
</html>

--------------02OjlxH0FfQwap19xwjB00Im--
--------------scR6AWr0IUd80RR4fMrzjkil
Content-Type: application/x-shellscript;
 name="reproducer_git_clone_dissociate.sh"
Content-Disposition: attachment; filename="reproducer_git_clone_dissociate.sh"
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgojIFJlcHJvZHVjZXIgZm9yIGdpdCBjbG9uZSAtLWRpc3NvY2lhdGUgZmFp
bHVyZSB3aGVuIHJlZmVyZW5jZSByZXBvIGhhcyBhIGNvbW1pdC1ncmFwaC4KIyBPYnNlcnZl
ZCBpbiBnaXQgdmVyc2lvbiAyLjU0LjAKCnNldCAtZQoKUkVQT19BPSIkKHB3ZCkvcmVwby1h
IgpSRVBPX0I9IiQocHdkKS9yZXBvLWIiCgojIENsZWFuIHVwIHByZXZpb3VzIHJ1bnMKcm0g
LXJmICIkUkVQT19BIiAiJFJFUE9fQiIKCmVjaG8gIj09PSBDcmVhdGluZyByZWZlcmVuY2Ug
cmVwb3NpdG9yeSB3aXRoIGNvbW1pdC1ncmFwaCA9PT0iCmdpdCBpbml0IC1iIG1hc3RlciAi
JFJFUE9fQSIKY2QgIiRSRVBPX0EiCmVjaG8gImNvbnRlbnQgMSIgPiBmaWxlICYmIGdpdCBh
ZGQgZmlsZSAmJiBnaXQgY29tbWl0IC1tICJjb21taXQgMSIKZWNobyAiY29udGVudCAyIiA+
IGZpbGUgJiYgZ2l0IGFkZCBmaWxlICYmIGdpdCBjb21taXQgLW0gImNvbW1pdCAyIgpnaXQg
Y29tbWl0LWdyYXBoIHdyaXRlIC0tcmVhY2hhYmxlCmNkIC4uCgplY2hvIC1lICJcbj09PSBB
dHRlbXB0aW5nIGNsb25lIHdpdGggLS1yZWZlcmVuY2UgYW5kIC0tZGlzc29jaWF0ZSA9PT0i
CiMgVGhpcyBpcyBleHBlY3RlZCB0byBmYWlsIHdpdGggImZhdGFsOiB1bmFibGUgdG8gcGFy
c2UgY29tbWl0IC4uLiIKaWYgZ2l0IGNsb25lIC0tcmVmZXJlbmNlICIkUkVQT19BIiAtLWRp
c3NvY2lhdGUgImZpbGU6Ly8kUkVQT19BIiAiJFJFUE9fQiI7IHRoZW4KCWVjaG8gLWUgIlxu
U1VDQ0VTUzogQ2xvbmUgZmluaXNoZWQgY29ycmVjdGx5IChCdWcgbm90IHJlcHJvZHVjZWQp
IgplbHNlCgllY2hvIC1lICJcbkZBSUxVUkU6IENsb25lIGZhaWxlZCBhcyBleHBlY3RlZCAo
QnVnIHJlcHJvZHVjZWQpIgpmaQoKZWNobyAtZSAiXG49PT0gUmVwb3NpdG9yeSBzdGF0ZSBh
ZnRlciBmYWlsdXJlID09PSIKY2QgIiRSRVBPX0IiCmVjaG8gIkNoZWNraW5nIGlmIGFsdGVy
bmF0ZXMgZmlsZSBleGlzdHMgKHNob3VsZCBOT1QgZXhpc3QgYWZ0ZXIgZGlzc29jaWF0aW9u
KToiCmlmIFsgLWYgLmdpdC9vYmplY3RzL2luZm8vYWx0ZXJuYXRlcyBdOyB0aGVuCgllY2hv
ICIgIEFsdGVybmF0ZXMgZmlsZSBTVElMTCBFWElTVFMuIgplbHNlCgllY2hvICIgIEFsdGVy
bmF0ZXMgZmlsZSBHT05FIChEaXNzb2NpYXRpb24gZmluaXNoZWQpLiIKZmkKCmVjaG8gIkF0
dGVtcHRpbmcgbWFudWFsIGNoZWNrb3V0OiIKaWYgZ2l0IGNoZWNrb3V0IG1hc3RlciAyPi9k
ZXYvbnVsbDsgdGhlbgoJZWNobyAiICBNYW51YWwgY2hlY2tvdXQgU1VDQ0VFREVELiIKZWxz
ZQoJZWNobyAiICBNYW51YWwgY2hlY2tvdXQgRkFJTEVELiIKZmkK

--------------scR6AWr0IUd80RR4fMrzjkil--
