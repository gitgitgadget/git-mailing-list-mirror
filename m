From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: replace [^~] with escapes everywhere
Date: Tue, 16 Sep 2008 01:24:33 -0700
Message-ID: <7vy71s7b26.fsf@gitster.siamese.dyndns.org>
References: <1221470398-8698-1-git-send-email-trast@student.ethz.ch>
 <1221470398-8698-3-git-send-email-trast@student.ethz.ch>
 <32541b130809151656n4f39018fu2045eb6280d6da00@mail.gmail.com>
 <200809160205.23371.trast@student.ethz.ch>
 <32541b130809151710j59963af9id84b3c1553ec738d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Thomas Rast" <trast@student.ethz.ch>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 10:26:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfVsi-0007Hl-E6
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 10:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYIPIYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 04:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbYIPIYo
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 04:24:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbYIPIYn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 04:24:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 809D162AD8;
	Tue, 16 Sep 2008 04:24:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ADD2962AD6; Tue, 16 Sep 2008 04:24:35 -0400 (EDT)
In-Reply-To: <32541b130809151710j59963af9id84b3c1553ec738d@mail.gmail.com>
 (Avery Pennarun's message of "Mon, 15 Sep 2008 20:10:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E84E8C70-83C8-11DD-AA37-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95991>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> On Mon, Sep 15, 2008 at 8:05 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>> Avery Pennarun wrote:
>>> Rather than uglifying all the documentation to work around the syntax,
>>> perhaps we just want to disable subscripts and superscripts
>>> altogether?  I can't really imagine the git documentation needing
>>> them.
>>>
>>> To do so, we can add these lines to asciidoc.conf (I just did this on
>>> another project yesterday, but I haven't tested in git.git):
>>>
>>> [replacements]
>>> # Disable superscripts.
>>> \^(.+?)\^=^\1^
>>> # Disable subscripts.
>>> ~(.+?)~=~\1~
>>
>> That's indeed a far superior solution.  I withdraw my patches in
>> favour of this.
>
> Er, do you mind submitting (and testing :)) a new patch that does it?
> I don't have time right now.

Sorry, but this unfortunately does not seem to help asciidoc 8.2.5 on FC9
at all, which is the combination used at k.org machine that feeds the
html/man branches to everybody else.

asciidoc 7.1.2 on Deb does not have the problem in git-bundle.html to
begin with, but it does have the same issue in git-show-ref.html, which
the patch does fix.

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 40d43b7..8fcdb54 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -15,6 +15,12 @@ startsb=&#91;
 endsb=&#93;
 tilde=&#126;
 
+[replacements]
+# Disable superscripts.
+\^(.+?)\^=^\1^
+# Disable subscripts.
+~(.+?)~=~\1~
+
 ifdef::backend-docbook[]
 [linkgit-inlinemacro]
 {0%{target}}
