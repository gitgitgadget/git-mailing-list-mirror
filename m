From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] "hash-object --literally" fixes
Date: Mon,  4 May 2015 14:37:27 -0700
Message-ID: <1430775451-31130-1-git-send-email-gitster@pobox.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 23:37:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpO3e-0001H7-5r
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 23:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbbEDVhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 17:37:43 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752078AbbEDVhe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 17:37:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 792F94FA14;
	Mon,  4 May 2015 17:37:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zLXP
	O6EDFh18mUGpCCQTyZiJPHY=; b=UEgEmKAqI5Vff+SRgGDYUvMHHbN4iiOx/BSp
	6jw19HeavTiNY9ZUL8Gdwtl8wjcxKGw4ogPWxmROED8Ma8h1Bc+5exZevSeS2l1B
	onod1ZASEqWev2htuGjbjfHcoWS3nzdtSnx9RKfJ7MKodO2KRuacNeVC95pWJTaT
	+FuXpoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	R3R1/R6IjKZTzx7Ii6cDEFq9Wn+Gu2T+R0sd+UtMRBcQAek8OENmyJS08r/uIOuK
	SQF2UoLp4Je0AzoEruES4Dacvek3mLoYk/+tx9MRpWe2uPXlAD2BYhZ7zP9KSzjo
	/Z0Cr30GdPTYNWSPFgydRm4wqmZ5w0KdhaExQ5vcq6c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 72F164FA13;
	Mon,  4 May 2015 17:37:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB9844FA12;
	Mon,  4 May 2015 17:37:32 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-307-g8f38e3e
In-Reply-To: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
X-Pobox-Relay-ID: C5C901E6-F2A5-11E4-B489-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268359>

This is a rework of Eric's fix (Thanks!), to avoid using strbuf all
the time, even when we are not doing "hash-object --literally".

Eric Sunshine (3):
  git-hash-object.txt: document --literally option
  write_sha1_file_prepare: fix buffer overrun with extra-long object type
  t1007: add hash-object --literally tests

Junio C Hamano (1):
  write_sha1_file(): do not use a separate sha1[] array

 Documentation/git-hash-object.txt | 10 ++++++++--
 builtin/hash-object.c             |  4 +---
 cache.h                           |  1 +
 sha1_file.c                       | 32 +++++++++++++++++++++++++++-----
 t/t1007-hash-object.sh            | 11 +++++++++++
 5 files changed, 48 insertions(+), 10 deletions(-)

-- 
2.4.0-302-g6743426
