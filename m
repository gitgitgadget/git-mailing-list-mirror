From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2] git-send-email.perl: improve detection of MIME 
	encoded-words
Date: Sun, 7 Jun 2009 19:31:20 -0500
Message-ID: <ee63ef30906071731j33c45b6dr3afcec2128023846@mail.gmail.com>
References: <ee63ef30906070945g62e94313r8b2a7128bde16f9d@mail.gmail.com>
	 <1244420758-5604-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 02:31:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDSmI-0003k5-Mn
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 02:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbZFHAbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 20:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbZFHAbT
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 20:31:19 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:30894 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbZFHAbS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 20:31:18 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1797543qwd.37
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 17:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DIpfuUnNg/cMbbq/tNu4bw/BfAev5rnhMo5CYI4TZHE=;
        b=JLjzmENZGpyztY3zFPXiWnDDleWIHOgt6zBOqToSm05exgxwPUXGKYYmxSUL8I0gwl
         E65iREwtktsiPaWu4/K0DWErq7HNSh93y1pl6p698YQSFD2l1CAxPGGWWRz9VytaOFyL
         St+Uuf2vCA6ZjkGOXuC60HZJEAZ3l4fHC2hg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n2eeFyPJUuOX5xwkIA1dkOzKleZ5uFR46TQ06Hyvsgx9W2U6x9XRfD46OaOkt5EP5b
         BHF6EOn3y8fxWnhsoS3EsZjuVfN/X0V+rnxffbch497BZdRosAyhC0oKloOXjw0XpMxw
         GcvvJCMnaSuLxhF89CgwnBwL1OLc61qgsjRGY=
Received: by 10.220.98.17 with SMTP id o17mr3186455vcn.86.1244421080291; Sun, 
	07 Jun 2009 17:31:20 -0700 (PDT)
In-Reply-To: <1244420758-5604-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121024>

On Sun, Jun 7, 2009 at 7:25 PM, Brandon Casey<drafnel@gmail.com> wrote:

> Here's a replacement patch which increases the range of excluded characters
> allowed as tokens so only ASCII characters are allowed (minus the other
> exclusions).

Here's the diff from the original patch:

diff --git a/git-send-email.perl b/git-send-email.perl
index e735815..8a1a40d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -774,7 +774,7 @@ sub quote_rfc2047 {

 sub is_rfc2047_quoted {
        my $s = shift;
-       my $token = '[^][()<>@,;:"\/?.= \000-\037\177]+';
+       my $token = '[^][()<>@,;:"\/?.= \000-\037\177-\377]+';
        my $encoded_text = '[!->@-~]+';
        length($s) <= 75 &&
        $s =~ m/^(?:"[[:ascii:]]*"|=\?$token\?$token\?$encoded_text\?=)$/o;

-brandon
