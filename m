From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/lib-git-svn.sh: use $PERL_PATH for perl, not perl from 
	$PATH
Date: Wed, 11 Aug 2010 18:45:12 +0000
Message-ID: <AANLkTikOnWpByxhUNsoOrvzJP83xJfLT6JJQZ4M2XnTN@mail.gmail.com>
References: <1281442465-27750-1-git-send-email-avarab@gmail.com>
	<7vzkwtxaot.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	"Philippe Bruhat (BooK)" <book@cpan.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 20:45:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGIk-0000OM-Kv
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 20:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970Ab0HKSpP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 14:45:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59502 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab0HKSpO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 14:45:14 -0400
Received: by fxm13 with SMTP id 13so345002fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AuJNfy7gB3EEr/1mq2ZQ4jW0GuW7xIshn6QyvKgeJ14=;
        b=RzTZiI8VzN+87sblD22Lab3ckQrAwDbLN6QMRhD+wm/XkWDouw4p/nmLbiC2DCDAuJ
         417X+ATShGjYh5qSO9ySirGt+JD2Tmp3anNQZ3QipjqnIQM7lsSZQ/ZcB2uU7uQY4Ozu
         BbfuZxWowXU7a6i+azETstAADnGRjgMm0U3ds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AUvwkYn8WAkcCYWM+xbo0WvGdJhHA5fnu02DgFJdZqT4sBKQ7ZeAI9kO7GXtXeRM23
         lsVBHX25gX7sCLoGhGgq7GfrGJCKKZN+k5IhSF8j6/aWtfCSPDnWbluQ2rIReBaGcoBG
         3Ac3t8yZ3oIr1uixICsD+jVt9tQKVtHa8xy+s=
Received: by 10.223.113.12 with SMTP id y12mr20619238fap.36.1281552313040; 
	Wed, 11 Aug 2010 11:45:13 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 11:45:12 -0700 (PDT)
In-Reply-To: <7vzkwtxaot.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153279>

On Wed, Aug 11, 2010 at 18:32, Junio C Hamano <gitster@pobox.com> wrote=
:
> Thanks. =C2=A0Other test scripts (and the insn in t/README) refer to =
PERL_PATH
> already and t/test-lib.sh includes build options for its definition, =
so
> this should be complete.

There's actually a lot more (most of these):

    $ ack -l '\bperl.*-\w*e' *sh
    annotate-tests.sh
    diff-lib.sh
    gitweb-lib.sh
    lib-t6000.sh
    t1010-mktree.sh
    t1300-repo-config.sh
    t3300-funny-names.sh
    t4012-diff-binary.sh
    t4014-format-patch.sh
    t4020-diff-external.sh
    t4029-diff-trailing-space.sh
    t4030-diff-textconv.sh
    t4031-diff-rewrite-binary.sh
    t4103-apply-binary.sh
    t4116-apply-reverse.sh
    t4200-rerere.sh
    t5300-pack-object.sh
    t5303-pack-corruption-resilience.sh
    t6011-rev-list-with-bad-commit.sh
    t6013-rev-list-reverse-parents.sh
    t6300-for-each-ref.sh
    t9104-git-svn-follow-parent.sh
    t9119-git-svn-info.sh
    t9129-git-svn-i18n-commitencoding.sh
    t9137-git-svn-dcommit-clobber-series.sh
    t9143-git-svn-gc.sh
    test-lib.sh

But they're all using standard features of perl for one-liners. It's a
reasonable assumption that we can use the perl in $PATH in those
cases. But maybe we should change those too.
