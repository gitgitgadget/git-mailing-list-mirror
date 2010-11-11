From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 11:32:53 -0600
Message-ID: <20101111173253.GC16972@burratino>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
 <20101111103742.GA16422@burratino>
 <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Carl Worth <cworth@cworth.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 18:33:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGb1Y-0008IP-CU
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 18:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab0KKRdT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 12:33:19 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62893 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618Ab0KKRdS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 12:33:18 -0500
Received: by vws13 with SMTP id 13so433702vws.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cJayz6aM5/hlAetKDK/CnyeieQhA8jay90qRBxdcwso=;
        b=oo0GRqexF2pS7z0P9h1a0cT/U84PsEU+dKXG3WSPhbqd8XHRZhdiaDanOdmX+hpeON
         QaOULYlJDW3vPTCplK6OsRH9JOGHsivpeOOEx3x7E91dFkL5X2n1VEkr1jZP6rgpbFmp
         V/AG5/E6mMupUO5JS9dkOLa4aRF3QnDAcOdvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lE10rxWldM5VojJ8esJFUagwVxKA5gchU7k9vMtcob6umKw6hhTPuqH2lO6osManTp
         cExIbRJbEvVNYCh0FWY0dzyTiWyTcK4gHTDA4HjIKVgr37P6gcnpI7VXW3tLum0mbfxH
         izF59fbhzPfXz4dC00GwhVkJR6kC+UoTOxD9g=
Received: by 10.220.191.13 with SMTP id dk13mr250558vcb.230.1289496797325;
        Thu, 11 Nov 2010 09:33:17 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id s12sm821944vbp.4.2010.11.11.09.33.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 09:33:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161273>

On Thu, Nov 11, 2010 at 07:16:27PM +0700, Nguyen Thai Ngoc Duy wrote:
> On Thu, Nov 11, 2010 at 5:37 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> Most likely the clone is terminating when Python exits, perhaps due =
to
>> SIGPIPE. =C2=A0It doesn't look like a bug to me; I suspect you meant=
 to use
>> os.system(), which is synchronous, instead.
[...]
> If "git clone" is terminated before it completes, shouldn't it clean
> the uncompleted repo?

Ah, so it should.

 trace: built-in: git clone jrn@localhost:/home/jrn/src/xz
 trace: run_command: ssh jrn@localhost git-upload-pack '/home/jrn/src/x=
z'
 trace: remove junk called
 jrn@localhosts password:=20
 trace: run_command: index-pack --stdin -v --fix-thin --keep=3Dfetch-pa=
ck 19314 on burratino
 trace: exec: git index-pack --stdin -v --fix-thin --keep=3Dfetch-pack =
19314 on burratino
 trace: built-in: git index-pack --stdin -v --fix-thin --keep=3Dfetch-p=
ack 19314 on burratino
 remote: Counting objects: 7299, done.
 remote: Compressing objects: 100% (1826/1826), done.
 remote: Total 7299 (delta 5421), reused 7274 (delta 5401)
 Receiving objects: 100% (7299/7299), 2.36 MiB | 4.43 MiB/s, done.
 Resolving deltas: 100% (5421/5421), done.
 trace: exited with status 0
 trace: exited with status 0
 trace: remove junk called
 trace: remove_junk: pid !=3D 0

Are there any downside to the following?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/builtin/clone.c b/builtin/clone.c
index 19ed640..af6b40a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -667,6 +667,5 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
 	strbuf_release(&value);
-	junk_pid =3D 0;
 	return err;
 }
