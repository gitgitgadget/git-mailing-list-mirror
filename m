From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Teaching -Xours/-Xtheirs to binary ll-merge driver
Date: Sat,  8 Sep 2012 21:40:37 -0700
Message-ID: <1347165639-12149-1-git-send-email-gitster@pobox.com>
References: <7v392twlnm.fsf@alter.siamese.dyndns.org>
Cc: Stephen Bash <bash@genarts.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 06:41:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAZL1-0006Fo-IL
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 06:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286Ab2IIEkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 00:40:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39446 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab2IIEkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 00:40:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 536259E92;
	Sun,  9 Sep 2012 00:40:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/880
	pNMeDWK7cq2znPl97aX2Ic0=; b=qafCrW/EXENHXbeCpj2UMe0bqT9EjdgqNcOT
	8Niv5PiJ2XJIVnNzM3SD5Ya9GzSN0SdlI9MIWCO9S96fsI7cbL0dTfWcxr6rN7Z2
	FBNSnxNnTdMAyCIs3sqU//h4VnVIPU25AXyeYJl3oNy3pg6fIZpsaHjQlzHvUcrc
	MfiFlXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	XjUwF5Fqdb2IlarkCbO2l41gzrYFoxAzGEE6WmSv1vsrO5WPoakcc/AmAlop0QDf
	XFcoei2HiG8nvCk1lGYuUsjFZiAAik+5hBOktVxRhmfteXGx0pydmxY42lWl64N5
	OTdz0WUZZ1X2Y4zV3agsi1ZoUyTxa7a2UvJEeGfMhHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4008B9E91;
	Sun,  9 Sep 2012 00:40:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF7E59E90; Sun,  9 Sep 2012
 00:40:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.322.g2c7d289
In-Reply-To: <7v392twlnm.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 82321246-FA38-11E1-8208-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205037>

The part that grants Stephen's wish is unchanged from the earlier
"perhaps like this" patch, but this time with a bit of documentation
and test.

A more important change between the two actually is [PATCH 2/2].
When a "binary" synthetic attribute is given to a path, we used to
(1) disable textual diff and (2) disable CR/LF conversion, but it is
also sane to disable the textual merge for a path marked as
"binary", and setting the "-merge" attribute to summon the "binary"
ll-merge driver is the way to do so.

Junio C Hamano (2):
  merge: teach -Xours/-Xtheirs to binary ll-merge driver
  attr: "binary" attribute should choose built-in "binary" merge driver

 Documentation/gitattributes.txt    |  2 +-
 Documentation/merge-strategies.txt |  3 ++-
 attr.c                             |  2 +-
 ll-merge.c                         | 25 ++++++++++++++++++++-----
 t/t6037-merge-ours-theirs.sh       | 14 +++++++++++++-
 5 files changed, 37 insertions(+), 9 deletions(-)

-- 
1.7.12.322.g2c7d289
