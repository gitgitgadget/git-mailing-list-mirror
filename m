Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="m7l83zFs"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F152269A
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 03:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701863537; x=1702468337; i=l.s.r@web.de;
	bh=ZjTO4m2XZnz8HmheCJ3mZc9osciZFPGJTzTsDeKAfKQ=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=m7l83zFsUCy/+kJ1MhL/jnu5l/8vYfeSag1xz5kNGzjQXuG0/VGL2FYR5sbs0emI
	 dy9pVuFqVwc4rUAuEnxNiBrJEf0bxVr4Y9HUyr4z1mycX4g8NHT7ZWrqHGoVw4uBK
	 BU3XomsEtv6hHYyliUnSviX/1dMM/GmNYVxznHeE2p7GoQ1QHemsGuSn3WBoY7V3u
	 2lihdeTmJmRS35bxRmdWtGMuTs6GCk9MVfcZxK9lbSc56ooN1AuqmUpeeJEHPM/2Y
	 X6MFVnS25g7aPaC2ZflnSyUQQBwv/WJlMv9B0EbY6TnjDzPMIXLVjWsudspY121+o
	 84PXy1iL4/TaK4sOTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.29.38]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MDvDi-1r37Cv19CW-009vyH for <git@vger.kernel.org>; Wed, 06 Dec 2023 12:52:17
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 7/7] worktree: simplify incompatibility message for --orphan and commit-ish
Date: Wed,  6 Dec 2023 12:52:01 +0100
Message-ID: <20231206115215.94467-8-l.s.r@web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206115215.94467-1-l.s.r@web.de>
References: <20231206115215.94467-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MXw5SHVEKCJRAivH1HK94ENkYaWT47zMzN6PwvK3yvxMZyQGpgx
 LBcYY2D6e8rL0SGeI16Gh3mniwMH/faHayhjkO5UuJJBbas+akJOG615o4U9SsZjUfkFU3q
 xIBDwKoOVH1CLSDBSrlAfXo+FJg+8iKYeA8bNM+5WrG2DJJ0bTd/7PDvQa5CBdCYqj+KOsG
 bQt7aCV7EYbZ0WWcVrFfQ==
UI-OutboundReport: notjunk:1;M01:P0:yeMB4ASYTTc=;Lohk/+lB6yeFvJGwYWpl9+ut4Zs
 FPEfrli4gJOmWchsHdTUTLNz5Rrbh1Xi6RrFlgG2+SWCw0DKB1WtOxMTjFzx4gYMH6M668rGz
 uZcMMZyHEfqgvnpGPxSmreGIiP6yjfaK4/Lg9mwa6nSnE95a7RDxKmhdJXbnAmDmoteM02pjz
 FsUMr64t1XKR3ySyGnSJuN/3JD4+qvPktC2gCS20s41tGaVB6o1SCB10+JQD1gFzIGTWJ3XkC
 7/5HVPpfhrMcmjfdeH1aFjPLLwo/tIh4yGfL5L4L4oG/wldhJ28p/SH9iTD6Jx/TyllofKYqo
 u/GwTB58nJPFLqrlrAKEVrJtQ2Vy2XrBanGMe8y2OsqQHXfo0BhNnNrn5BUU0PxOHzLNQEQBq
 vRL+hP4uZWZuMSDwZNCVVm6GX6n8p5TPU1ww94x2v/lxfD07RGg7IRYUaVMsMKlSA0xUX769x
 +GFqtAjL/BUGzvdAZHyWX9G9rcCFTlj4i9e3yRCGLnnSb7dxA7QpXprGKKFViPm4cKDb+nYhs
 uNSP71VENx/G3SffGSqFGO7uTrHez0b9vlayB+vbJUlf6uLWXx8AP95oow6XG+vcPKf/71b6x
 3v8KaIN602CTK6DjUKBXt3AlvBsxJmScl3Cra3AK1/CiVdQtv3jkCwJnx+grg3b0cY+Q3BfRP
 0yDELnrf1Strdp9G3l0DRFWfEMwvyw6OUpiES0QyIDPDBeZknyaRk/7t5j9wCxe7nMu8RUdge
 jnGrcNB9MNlyKNxxI+tcfRIBhcjZUFABz6aBKKWTLXjGclW24G6/ugRtNIM2JN6W0skhP53fL
 823Sf58xnZakkljB2RK/mb1DqBOVtdvorX4vkXh3Q9yHFGygdnEMeEWf1GmHhMzuG6bEA58kk
 4xWQaGL+7bkULhA6iF7dpelZMA9j8Ds+qUrnF922+PpLod3n61QQtCbSHEXey836sPpvOAWJg
 BvFwKFEMUO0wo4j/I0eisUE7RoM=

Use a single translatable string to report that the worktree add option
=2D-orphan is incompatible with a commit-ish instead of having the
commit-ish in a separate translatable string.  This reduces the number
of strings to translate and gives translators the full context.

A similar message is used in builtin/describe.c, but with the plural of
commit-ish, and here we need the singular form.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/worktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 036ceaa981..4ac1621541 100644
=2D-- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -815,8 +815,8 @@ static int add(int ac, const char **av, const char *pr=
efix)
 		die(_("options '%s' and '%s' cannot be used together"),
 		    "--orphan", "--no-checkout");
 	if (opts.orphan && ac =3D=3D 2)
-		die(_("'%s' and '%s' cannot be used together"), "--orphan",
-		    _("<commit-ish>"));
+		die(_("option '%s' and commit-ish cannot be used together"),
+		    "--orphan");
 	if (lock_reason && !keep_locked)
 		die(_("the option '%s' requires '%s'"), "--reason", "--lock");
 	if (lock_reason)
=2D-
2.43.0

