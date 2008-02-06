From: MALET Jean-Luc <jeanluc.malet@gmail.com>
Subject: [BUG] DOS filetype and pre_commit hook
Date: Wed, 06 Feb 2008 23:22:50 +0100
Message-ID: <47AA333A.8040403@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060503050506070607050008"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 23:23:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMsg0-0004Pe-Pg
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 23:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249AbYBFWW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 17:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755844AbYBFWW7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 17:22:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:5328 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbYBFWW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 17:22:58 -0500
Received: by nf-out-0910.google.com with SMTP id g13so812346nfb.21
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 14:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        bh=xM/IMZW/SCNH+06M8MmE8/E1LEHJ/VEYGS2gIsWNx3o=;
        b=R1JhJLnEyL+nPny+lI6lcfE+M9yjgK8uTzgrs4SJ8Af+njQOhZjhvJuccZVQnIXI9aox8uDyeg81Pfckna5R1Ybgv64U00N+HPuM0MTkqrFSDx/EhIFV/2habOwVSB5LyLSJR/KUFnOhJIaMhwRHp2p+5xdFsHXj8PE/5Yp9QsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=Pp7+ZjWZfC1WS1CSx8aajTnOpQ0rD9qR/qhTkxwZsu86Nv1LNXJtNvkx5NgU31doVsbE9AjdXMYEIv66ue7+9OyRo3f3zIhUh/MV/QAeV60x1lh6t84xar3iA/s2fSin7BOudbCxQB0cq83kvyyqpxhu3rg1WMBaGtE7y0xyuuw=
Received: by 10.86.26.11 with SMTP id 11mr9629510fgz.74.1202336574804;
        Wed, 06 Feb 2008 14:22:54 -0800 (PST)
Received: from jlmport.sorcerer ( [84.97.115.36])
        by mx.google.com with ESMTPS id d4sm10726850fga.2.2008.02.06.14.22.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Feb 2008 14:22:53 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071120)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72864>

This is a multi-part message in MIME format.
--------------060503050506070607050008
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I use git for tracking change on the project I'm working on and the 
sourcecode is in dos text encoding (<CR><LF>)
when I commit I have to use the --no-verify option because the perl part 
of the hook (btw isn't it possible to have git not depend on perl?) 
don't use the right regexp to track if there is trailing whitespace
the corresponding regex to be used with grep is :
grep -E '^\+.*[[:blank:]]+[[:space:]]$'

because <CR> is matched by [[:space:]] and then a line like :

no trailing whitespace<CR><LF>

will trigger a trailing whitespace event

See the attached file that correct the issue

Best Regards,
JLM

-- 
KISS! (Keep It Simple, Stupid!)
(garde le simple, imbécile!)
"mais qu'est-ce que tu m'as pondu comme usine à gaz? fait des choses 
simples et qui marchent, espèce d'imbécile!"

--------------060503050506070607050008
Content-Type: application/octet-stream;
 name="pre-commit"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pre-commit"

IyEvYmluL3NoCiMKIyBBbiBleGFtcGxlIGhvb2sgc2NyaXB0IHRvIHZlcmlmeSB3aGF0IGlz
IGFib3V0IHRvIGJlIGNvbW1pdHRlZC4KIyBDYWxsZWQgYnkgZ2l0LWNvbW1pdCB3aXRoIG5v
IGFyZ3VtZW50cy4gIFRoZSBob29rIHNob3VsZAojIGV4aXQgd2l0aCBub24temVybyBzdGF0
dXMgYWZ0ZXIgaXNzdWluZyBhbiBhcHByb3ByaWF0ZSBtZXNzYWdlIGlmCiMgaXQgd2FudHMg
dG8gc3RvcCB0aGUgY29tbWl0LgojCiMgVG8gZW5hYmxlIHRoaXMgaG9vaywgbWFrZSB0aGlz
IGZpbGUgZXhlY3V0YWJsZS4KCiMgVGhpcyBpcyBzbGlnaHRseSBtb2RpZmllZCBmcm9tIEFu
ZHJldyBNb3J0b24ncyBQZXJmZWN0IFBhdGNoLgojIExpbmVzIHlvdSBpbnRyb2R1Y2Ugc2hv
dWxkIG5vdCBoYXZlIHRyYWlsaW5nIHdoaXRlc3BhY2UuCiMgQWxzbyBjaGVjayBmb3IgYW4g
aW5kZW50YXRpb24gdGhhdCBoYXMgU1AgYmVmb3JlIGEgVEFCLgoKb3V0cHV0X2ZhaWxpbmdf
bGluZSgpIHsKCXdoaWxlIFsgJCMgLWd0IDAgXTsgZG8KCQlsaW5lbm89JHsxLzoqL30KCQls
aW5lbm89JCgoJHtsaW5lbm99LTUpKQoJCWxpbmU9JHsxLyorL30KCQllY2hvICIke2xpbmVu
b30gOiAke2xpbmV9IgoJCXNoaWZ0Cglkb25lCn0KCmlmIGdpdC1yZXYtcGFyc2UgLS12ZXJp
ZnkgSEVBRCAyPi9kZXYvbnVsbAp0aGVuCglPTERJRlM9JHtJRlN9CglJRlM9JCdcbicKCWVy
cm9yPTAKCUZJTEVfTElTVD0kKGdpdC1kaWZmLWluZGV4IC0tbmFtZS1vbmx5ICAtTSAtLWNh
Y2hlZCAgSEVBRCAtLSkKCWZvciBmaWxlIGluICR7RklMRV9MSVNUfTsgZG8KCQlsaW5lX2Nv
dW50PSQod2MgLWwgJHtmaWxlfSkKCQlsaW5lX2NvdW50PSR7bGluZV9jb3VudC8gKi99CgkJ
dHJhaWxpbmc9JChnaXQtZGlmZiAtcCAtLXVuaWZpZWQ9JHtsaW5lX2NvdW50fSAtLWNhY2hl
ZCBIRUFEIC0tICR7ZmlsZX0gfCBncmVwIC1FbiAnXlwrLipbWzpibGFuazpdXStbWzpzcGFj
ZTpdXSQnKQoJCWJhZGluZGVudD0kKGdpdC1kaWZmIC1wIC0tdW5pZmllZD0ke2xpbmVfY291
bnR9IC0tY2FjaGVkIEhFQUQgLS0gJHtmaWxlfSB8IGdyZXAgLUVuICdeXCtbIF0qCScpCgkJ
YmFkbGluZT0kKGdpdC1kaWZmIC1wIC0tdW5pZmllZD0ke2xpbmVfY291bnR9IC0tY2FjaGVk
IEhFQUQgLS0gJHtmaWxlfSB8IGdyZXAgLUVuICdeXCsoPzpbPD49XSl7N30nKQoJCWlmIFsg
LW4gIiR7dHJhaWxpbmd9IiBdIHx8IFsgLW4gIiR7YmFkaW5kZW50fSIgXSB8fCBbIC1uICIk
e2JhZGxpbmV9IiBdOyB0aGVuCgkJCWVjaG8KCQkJZWNobyAiLS0tLS0tIEZBSUxFRCBQUkUg
Q09NTUlUIENIRUNLIC0tLS0tIgoJCQllY2hvIFlvdSBoYXZlIHNvbWUgc3VzcGljaW91cyBw
YXRjaCBsaW5lczoKCQkJZWNobyAke2ZpbGV9IDogdHJhaWxpbmcgd2hpdGVzcGFjZQoJCQlv
dXRwdXRfZmFpbGluZ19saW5lICR7dHJhaWxpbmd9CgkJCWVjaG8gJHtmaWxlfSA6IGluZGVu
dCBTUCBmb2xsb3dlZCBieSBhIFRBQgoJCQlvdXRwdXRfZmFpbGluZ19saW5lICR7YmFkaW5k
ZW50fQoJCQllY2hvICR7ZmlsZX0gOiB1bnJlc29sdmVkIG1lcmdlIGNvbmZsaWN0CgkJCW91
dHB1dF9mYWlsaW5nX2xpbmUgJHtiYWRsaW5lfQoJCQllY2hvICItLS0tLS0gRkFJTEVEIFBS
RSBDT01NSVQgQ0hFQ0sgLS0tLS0iCgkJCWVycm9yPTEKCQlmaQoJZG9uZQogICBleGl0ICR7
ZXJyb3J9CmVsc2UKCSMgTkVFRFNXT1JLOiB3ZSBzaG91bGQgcHJvZHVjZSBhIGRpZmYgd2l0
aCBhbiBlbXB0eSB0cmVlIGhlcmUKCSMgaWYgd2Ugd2FudCB0byBkbyB0aGUgc2FtZSB2ZXJp
ZmljYXRpb24gZm9yIHRoZSBpbml0aWFsIGltcG9ydC4KCToKZmkKCg==
--------------060503050506070607050008--
