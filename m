Received: from a11-80.smtp-out.amazonses.com (a11-80.smtp-out.amazonses.com [54.240.11.80])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE80409121
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486546; cv=none; b=TIkTk5p89Or3N7Zcayv58U36m/QcWggAvp2ObpyWDtybX69vB0nCpK2fkSrSEz7z7rbr73XK0qyD+1FxOm5+Sn7AHk6RDprgVYDZIvRc3VFvAiHr+etLnqnM4HcRJuR2XgVMXU7wZbwqPEN1/Hu9PRPye0qm2sYJPk7PZMy49kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486546; c=relaxed/simple;
	bh=PpfbPLB28yx6C4ELN/31i/8a+b7Ofmd5/qn0s8qAn98=;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:
	 Message-ID; b=URc5v+GhPyZK5Jp3fCC+9qqInSxQJbaCXKCQmHnBji1PrQOv79KtqLMtUxkAmJSKJm1ltcvhlS5eWoDo1v9O6sOVEXFU2VyoWBRqkZSC5JadfN+IonMYNuFLWELSHZTo+6OQ+B2/6rZsWn9S9ot6WtaNfldMGPkLSmj1jFxWZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ke8otq.us; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=ke8otq.us header.i=@ke8otq.us header.b=b4NrAOsf; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=djHP7w7Y; arc=none smtp.client-ip=54.240.11.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ke8otq.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ke8otq.us header.i=@ke8otq.us header.b="b4NrAOsf";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="djHP7w7Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=wvc2fjl5io2q6eb6pi6nhi5be2zn6o7n; d=ke8otq.us; t=1786486543;
	h=Subject:From:To:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
	bh=PpfbPLB28yx6C4ELN/31i/8a+b7Ofmd5/qn0s8qAn98=;
	b=b4NrAOsf06gvAfIclb0INZ0gdHv+bM2hxf3VRSApIDo18LMU3+Z4ElXXrhAUHqTU
	aBuuTndliHiaYzI/ecAQrQ4TJgi+2u3LrqgtuONld8nA2c8A3kYvuDumptcDmVRPwUw
	2/UVnNYmt9VnvBsUz/Hhjtxqh+V2FzmwlLViXGeQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1786486543;
	h=Subject:From:To:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
	bh=PpfbPLB28yx6C4ELN/31i/8a+b7Ofmd5/qn0s8qAn98=;
	b=djHP7w7YWJ/HeD13TQ6yRLERZFMdgVQUyo9DqBTkGmb4iZ7/r79CbnGOKwuS/MtQ
	SuVSRbqD3k/gDtVcp4cD2aEr0qCoDHsYNWHbFbKZf7wk+cy4sH9FmAfNoFjrpn6/Zly
	nmH3CMnCtQ8GNWX/ix5bFdR3xFfzHqRG+7aylsB8=
Subject: git-remote-https not sending BASIC auth to a proxy, when given
 HTTP_PROXY env vars containing a username:password pair and challenged with
 a 407.
From: =?UTF-8?Q?Tom_Noonan_II?= <tom@ke8otq.us>
To: =?UTF-8?Q?git=40vger=2Ekernel=2Eorg?= <git@vger.kernel.org>
Date: Tue, 11 Aug 2026 22:15:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <20260811181516.4ecd2b8b@b31595252ccc>
X-Mailer: Amazon WorkMail
Thread-Index: AQHdKd7y3PkMR1aqRbiPBsOoMLKRPg==
Thread-Topic: git-remote-https not sending BASIC auth to a proxy, when given
 HTTP_PROXY env vars containing a username:password pair and challenged with
 a 407.
X-Original-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
X-Wm-Sent-Timestamp: 1786486542
Message-ID: <0100019ff2e55472-01e0fe67-94de-4f1e-b0cf-65041aec5362-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.08.11-54.240.11.80

Good afternoon:=0D=0A=0D=0AI'm using git behind a authenticated HTTP prox=
y which uses basic auth.=0D=0AI have the common HTTP[S]_PROXY ENV vars se=
t properly with a standard=0D=0A`http://user:pass@host` URL for the proxy=
=2E  When I `git clone` the clone=0D=0Afails immediately with a `Proxy CO=
NNECT` aborted error I've tracked=0D=0Adown to git-remote-https:=0D=0A=0D=
=0A$ echo -e "capabilities\nlist" | GIT_CURL_VERBOSE=3D1 GIT_TRACE=3D1 /u=
sr/lib/git-core/git-remote-https origin https://github.com/terraform-aws-=
modules/terraform-aws-eks.git=0D=0Astateless-connect=0D=0Afetch=0D=0Aget=0D=
=0Aoption=0D=0Apush=0D=0Acheck-connectivity=0D=0Aobject-format=0D=0A=0D=0A=
17:39:50.167960 http.c:913              =3D=3D Info: Couldn't find host g=
ithub.com in the .netrc file; using defaults=0D=0A17:39:50.168253 http.c:=
913              =3D=3D Info:   Trying 192.168.128.1:3128...=0D=0A17:39:5=
0.172400 http.c:913              =3D=3D Info: CONNECT tunnel: HTTP/1.1 ne=
gotiated=0D=0A17:39:50.172424 http.c:913              =3D=3D Info: alloca=
te connect buffer=0D=0A17:39:50.172549 http.c:913              =3D=3D Inf=
o: Establish HTTP proxy tunnel to github.com:443=0D=0A17:39:50.172799 htt=
p.c:860              =3D> Send header, 0000000111 bytes (0x0000006f)=0D=0A=
17:39:50.172809 http.c:872              =3D> Send header: CONNECT github.=
com:443 HTTP/1.1=0D=0A17:39:50.172812 http.c:872              =3D> Send h=
eader: Host: github.com:443=0D=0A17:39:50.172813 http.c:872              =
=3D> Send header: User-Agent: git/2.47.3=0D=0A17:39:50.172815 http.c:872 =
             =3D> Send header: Proxy-Connection: Keep-Alive=0D=0A17:39:50=
=2E172816 http.c:872              =3D> Send header:=0D=0A17:39:52.403232 =
http.c:860              <=3D Recv header, 0000000044 bytes (0x0000002c)=0D=
=0A17:39:52.403249 http.c:872              <=3D Recv header: HTTP/1.1 407=
 Proxy Authentication Required=0D=0A17:39:52.403265 http.c:860           =
   <=3D Recv header, 0000000020 bytes (0x00000014)=0D=0A17:39:52.403267 h=
ttp.c:872              <=3D Recv header: Server: squid/6.13=0D=0A17:39:52=
=2E403277 http.c:860              <=3D Recv header, 0000000019 bytes (0x0=
0000013)=0D=0A17:39:52.403278 http.c:872              <=3D Recv header: M=
ime-Version: 1.0=0D=0A17:39:52.403694 http.c:860              <=3D Recv h=
eader, 0000000037 bytes (0x00000025)=0D=0A17:39:52.403704 http.c:872     =
         <=3D Recv header: Date: Tue, 11 Aug 2026 21:39:52 GMT=0D=0A17:39=
:52.403724 http.c:860              <=3D Recv header, 0000000039 bytes (0x=
00000027)=0D=0A17:39:52.403726 http.c:872              <=3D Recv header: =
Content-Type: text/html;charset=3Dutf-8=0D=0A17:39:52.403736 http.c:860  =
            <=3D Recv header, 0000000022 bytes (0x00000016)=0D=0A17:39:52=
=2E403738 http.c:872              <=3D Recv header: Content-Length: 1325=0D=
=0A17:39:52.403755 http.c:860              <=3D Recv header, 0000000042 b=
ytes (0x0000002a)=0D=0A17:39:52.403756 http.c:872              <=3D Recv =
header: X-Squid-Error: ERR_CACHE_ACCESS_DENIED 0=0D=0A17:39:52.403766 htt=
p.c:860              <=3D Recv header, 0000000023 bytes (0x00000017)=0D=0A=
17:39:52.403768 http.c:872              <=3D Recv header: Vary: Accept-La=
nguage=0D=0A17:39:52.403777 http.c:860              <=3D Recv header, 000=
0000022 bytes (0x00000016)=0D=0A17:39:52.403779 http.c:872              <=
=3D Recv header: Content-Language: en=0D=0A17:39:52.403804 http.c:860    =
          <=3D Recv header, 0000000066 bytes (0x00000042)=0D=0A17:39:52.4=
03806 http.c:872              <=3D Recv header: Proxy-Authenticate: Basic=
 realm=3D"<Redacted>"=0D=0A<Snip identifying headers>=0D=0A17:39:52.40387=
9 http.c:860              <=3D Recv header, 0000000019 bytes (0x00000013)=
=0D=0A17:39:52.403881 http.c:872              <=3D Recv header: Connectio=
n: close=0D=0A17:39:52.403886 http.c:860              <=3D Recv header, 0=
000000002 bytes (0x00000002)=0D=0A17:39:52.403888 http.c:872             =
 <=3D Recv header:=0D=0A17:39:52.403891 http.c:913              =3D=3D In=
fo: Ignore 1325 bytes of response-body=0D=0A17:39:52.403894 http.c:913   =
           =3D=3D Info: Proxy CONNECT aborted=0D=0A17:39:52.403904 http.c=
:913              =3D=3D Info: closing connection #0=0D=0Afatal: unable t=
o access 'https://github.com/terraform-aws-modules/terraform-aws-eks.git/=
': Proxy CONNECT aborted=0D=0A=0D=0AAs I understand it not sending creden=
tials initially is expected.=0D=0AHowever, my understanding is it should =
retry with auth when it receives=0D=0Athe 407, which it is not doing.  I'=
m unable to determine if this is=0D=0Aexpected or a bug.=0D=0A=0D=0AIf I =
set GIT_HTTP_PROXY_AUTHMETHOD=3Dbasic it works as expected:=0D=0A=0D=0A$ =
echo -e "capabilities\nlist" | GIT_CURL_VERBOSE=3D1 GIT_TRACE=3D1 GIT_HTT=
P_PROXY_AUTHMETHOD=3Dbasic /usr/lib/git-core/git-remote-https origin http=
s://github.com/terraform-aws-modules/terraform-aws-eks.git=0D=0Astateless=
-connect=0D=0Afetch=0D=0Aget=0D=0Aoption=0D=0Apush=0D=0Acheck-connectivit=
y=0D=0Aobject-format=0D=0A=0D=0A17:42:30.323214 http.c:913              =3D=
=3D Info: Couldn't find host github.com in the .netrc file; using default=
s=0D=0A17:42:30.323494 http.c:913              =3D=3D Info:   Trying 192.=
168.128.1:3128...=0D=0A17:42:30.324493 http.c:913              =3D=3D Inf=
o: CONNECT tunnel: HTTP/1.1 negotiated=0D=0A17:42:30.324595 http.c:913   =
           =3D=3D Info: allocate connect buffer=0D=0A17:42:30.324657 http=
=2Ec:913              =3D=3D Info: Proxy auth using Basic with user '<red=
acted>'=0D=0A17:42:30.324683 http.c:913              =3D=3D Info: Establi=
sh HTTP proxy tunnel to github.com:443=0D=0A17:42:30.324763 http.c:860   =
           =3D> Send header, 0000000172 bytes (0x000000ac)=0D=0A17:42:30.=
324787 http.c:872              =3D> Send header: CONNECT github.com:443 H=
TTP/1.1=0D=0A17:42:30.324797 http.c:872              =3D> Send header: Ho=
st: github.com:443=0D=0A17:42:30.324802 http.c:872              =3D> Send=
 header: Proxy-Authorization: Basic <redacted>=0D=0A17:42:30.324803 http.=
c:872              =3D> Send header: User-Agent: git/2.47.3=0D=0A17:42:30=
=2E324814 http.c:872              =3D> Send header: Proxy-Connection: Kee=
p-Alive=0D=0A17:42:30.324820 http.c:872              =3D> Send header:=0D=
=0A17:42:32.440551 http.c:860              <=3D Recv header, 0000000037 b=
ytes (0x00000025)=0D=0A17:42:32.440578 http.c:872              <=3D Recv =
header: HTTP/1.1 200 Connection established=0D=0A17:42:32.440601 http.c:8=
60              <=3D Recv header, 0000000002 bytes (0x00000002)=0D=0A17:4=
2:32.440612 http.c:872              <=3D Recv header:=0D=0A17:42:32.44062=
0 http.c:913              =3D=3D Info: CONNECT phase completed=0D=0A17:42=
:32.440624 http.c:913              =3D=3D Info: CONNECT tunnel establishe=
d, response 200=0D=0A17:42:32.440888 http.c:913              =3D=3D Info:=
 GnuTLS priority: NORMAL:-ARCFOUR-128:-CTYPE-ALL:+CTYPE-X509:-VERS-SSL3.0=
=0D=0A17:42:32.440962 http.c:913              =3D=3D Info: ALPN: curl off=
ers h2,http/1.1=0D=0A17:42:32.454273 http.c:913              =3D=3D Info:=
 found 151 certificates in /etc/ssl/certs/ca-certificates.crt=0D=0A17:42:=
32.492571 http.c:913              =3D=3D Info: found 453 certificates in =
/etc/ssl/certs=0D=0A17:42:32.588790 http.c:913              =3D=3D Info: =
SSL connection using TLS1.3 / ECDHE_RSA_AES_128_GCM_SHA256=0D=0A17:42:32.=
592774 http.c:913              =3D=3D Info:   server certificate verifica=
tion OK=0D=0A17:42:32.592859 http.c:913              =3D=3D Info:   serve=
r certificate status verification SKIPPED=0D=0A17:42:32.596435 http.c:913=
              =3D=3D Info:   common name: github.com (matched)=0D=0A17:42=
:32.596453 http.c:913              =3D=3D Info:   server certificate expi=
ration date OK=0D=0A17:42:32.596460 http.c:913              =3D=3D Info: =
  server certificate activation date OK=0D=0A17:42:32.596503 http.c:913  =
            =3D=3D Info:   certificate public key: EC/ECDSA=0D=0A17:42:32=
=2E596514 http.c:913              =3D=3D Info:   certificate version: #3=0D=
=0A17:42:32.596543 http.c:913              =3D=3D Info:   subject: CN=3Dg=
ithub.com=0D=0A17:42:32.596592 http.c:913              =3D=3D Info:   sta=
rt date: Fri, 03 Jul 2026 00:00:00 GMT=0D=0A17:42:32.596611 http.c:913   =
           =3D=3D Info:   expire date: Wed, 30 Sep 2026 23:59:59 GMT=0D=0A=
17:42:32.596633 http.c:913              =3D=3D Info:   issuer: C=3DGB,O=3D=
Sectigo Limited,CN=3DSectigo Public Server Authentication CA DV E36=0D=0A=
17:42:32.596738 http.c:913              =3D=3D Info: ALPN: server accepte=
d h2=0D=0A17:42:32.596925 http.c:913              =3D=3D Info: Connected =
to 192.168.128.1 (192.168.128.1) port 3128=0D=0A17:42:32.596945 http.c:91=
3              =3D=3D Info: using HTTP/2=0D=0A17:42:32.597008 http.c:913 =
             =3D=3D Info: [HTTP/2] [1] OPENED stream for https://github.c=
om/terraform-aws-modules/terraform-aws-eks.git/info/refs=3Fservice=3Dgit-=
upload-pack=0D=0A<Snip remaining successful log lines>=0D=0A=0D=0ASo, is =
the initial connection not using auth expected=3F=0D=0AIs it not trying a=
uth on 407 also expected=3F  If not, is this a known bug=3F=0D=0A=0D=0A--=
Tom Noonan II=0D=0A
