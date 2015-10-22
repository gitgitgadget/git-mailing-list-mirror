From: Alexander Riesen <alexander.riesen@cetitec.com>
Subject: [PATCH] Consider object stores in alternates during a dissociating
 clone
Date: Thu, 22 Oct 2015 15:59:11 +0200
Message-ID: <5628EBAF.1030205@cetitec.com>
References: <561F8DE9.4040703@cetitec.com>	<alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>	<561FBA48.3050609@cetitec.com> <56274922.80007@cetitec.com> <xmqqpp085cth.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 16:00:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpGPb-0005Ry-Ks
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 16:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757838AbbJVN75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 09:59:57 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:49750 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757827AbbJVN7z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 09:59:55 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue004) with ESMTPSA (Nemesis) id
 0Lxbix-1aa39J0DJj-017DTH; Thu, 22 Oct 2015 15:59:18 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id CAA41B00F23;
	Thu, 22 Oct 2015 15:59:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eFxvUNdMad3E; Thu, 22 Oct 2015 15:59:11 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.11.230])
	by pflsmail.localdomain (Postfix) with ESMTPS id D8DB7B00F1A;
	Thu, 22 Oct 2015 15:59:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqqpp085cth.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:Rt/d1M/qPE9rfwnUATVLtWvtO1Mxrp085GIAJwKrh7FVMfC0NUa
 2mDPtAZZwHSkqzPlsy6jSJBhMj9DJcGgst5pWo+lIj7aD462qEOVUloQXLI2gh6pX8UoJqi
 UA3Xlq5N3T13qPJb0zeVzdX6ZklyQ3FL8pRcJl8lbJeEcpmzM1PQrrHhHJ/3yeR95hR7+M8
 Z+JPa8uUfDPvUOT2WZCCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IkTl1f5edyo=:BSRGfLMTIU9GNPnx1ZSR/v
 RlXHnJHtsry/1m3xLsAmxTlDelGA74BaJsldOiiQVkZRhZZWkYkTrCLNa/WF5mfVPLtbL9PXz
 IunfCB0CKEZ0loCbCHZZhoODVbgSAdRRHLHDvSXigQ6Wiw028qx+r9dsWKeGv9nnzhwaT2XiW
 nY3K32f6vB5VupBsA8kAiaJcaPfNugblCYkRo4M+NitLJfvPNg6PN1NCMJhec+EctcuKgyur8
 iLuPXKEdaC5/0K/NicWVbu4xiKEEOWOWgDTRvDvRvr5D4Hv5XlWfE3MFOqp86Z8BHw2UoOdTi
 JRktCywoicx7wQoJlWbjmeg8MEBxC3LY3UTSyA5GuzAHHEh7Oxv3IOcJWU7N8ZflpQNIwSBHs
 6LwLBau4Vf4FAY8HChrsuuRDT7ZppSQu3HH8h/sx+9D8nhSA9vEWRRC48EvhwJ4Wo0wESvL/6
 vNOAn3HQ1QLQKhRcpRx/bZhGx97v60ytPj0TgWRsjmKSq3S7VgsMr2cK9yuvYksfC8D/aRX35
 VAenCHGeqt3TUocEAObH0nqEOaZPow2Bgg1D553DS+A9miCj/1Jo0W+0VpaUgRlKXs1SfcXLI
 H7yVbR2kf6p/hHRQTTL7FYDgFnuRmwSEqNwd++Ujsqoa/JnFccwFdPPbax/ucdFwB06NS9u/Q
 04782LN0EbBrB2kZrhSH48/iQ2RYNG4qTUkx066xEYa2BwtlkQKMcX0gkvijWwG6ctUX5PiEi
 ECwXvloX3vXVNcfV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280054>

From: Alex Riesen <raa.lkml@gmail.com>

The "--reference" option is not the only way to provide a repository to borrow
objects from.
For instance, the objects/info/alternates of the origin repository lists
object stores which the origin repository borrowed objects from. During
clone operations which bypass a git aware transport (i.e.  simply copy the
things over, like git clone --local) the file is copied into the cloned
repository.
In such a case, even if there were no reference repositories given in the
command-line, there might be still something to "dissociate" the cloned
repository from, before it is really independent.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

On 10/21/2015 07:52 PM, Junio C Hamano wrote:
> The readers of this change need  to be enlightened with a log message
 > to remind them that "--reference" is not the only way. Namely, if
 > you start from a repository with $GIT_DIR/objects/info/alternates,
 > i.e. the original already borrows from somewhere, and bypass the
 > normal "Git aware" transport mechanism, i.e. "git clone --local",
 > then the resulting repository would also become dependent of the
 > object store that the original depended on before the clone. In
 > order to make it free-standing, you would need "--dissociate", but
 > there is no "--reference" involved in that use case.
 >
 > And once that is clarified, it becomes very clear why it is wrong to
 > blindly require "--reference" to be there on the command line when
 > "--dissociate" is given.

Indeed. Log message improved.

> As to the patch, I think this  one is much simpler and preferrable.
 > It would hurt those who make a clone without bypassing the normal
 > "Git aware" transport mechanism and pass "--dissociate" without
 > "--reference".  They will end up making a clone that does not need
 > repacking to dissociate, but with this patch they would spend extra
 > cycles to run an unnecessary repack.  To avoid that, I think you can
 > throw in an check at the beginning of dissociate_from_references()
 > to see if git_path("objects/info/alternates") is there and make the
 > function a no-op if there isn't.

I think I understand. How about this?

  builtin/clone.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9eaecd9..a7d0c07 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -801,11 +801,15 @@ static void write_refspec_config(const char *src_ref_prefix,
  static void dissociate_from_references(void)
  {
      static const char* argv[] = { "repack", "-a", "-d", NULL };
+    char *alts = git_pathdup("objects/info/alternates");

+    if (access(alts, F_OK) < 0)
+        return;
      if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
          die(_("cannot repack to clean up"));
-    if (unlink(git_path("objects/info/alternates")) && errno != ENOENT)
+    if (unlink(alts) && errno != ENOENT)
          die_errno(_("cannot unlink temporary alternates file"));
+    free(alts);
  }

  int cmd_clone(int argc, const char **argv, const char *prefix)
@@ -954,10 +958,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)

      if (option_reference.nr)
          setup_reference();
-    else if (option_dissociate) {
-        warning(_("--dissociate given, but there is no --reference"));
-        option_dissociate = 0;
-    }

      fetch_pattern = value.buf;
      refspec = parse_fetch_refspec(1, &fetch_pattern);
-- 
2.6.1.151.ge74ab91
