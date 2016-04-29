From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http: expand http.cookieFile as a path
Date: Fri, 29 Apr 2016 10:48:16 -0700
Message-ID: <xmqqfuu4z4pr.fsf@gitster.mtv.corp.google.com>
References: <20160429062357.12647-1-computersforpeace@gmail.com>
	<20160429062357.12647-2-computersforpeace@gmail.com>
	<20160429141212.GB26643@sigill.intra.peff.net>
	<20160429155532.GA57118@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:48:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awCWf-0006rq-0z
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 19:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbcD2RsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 13:48:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751045AbcD2RsU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 13:48:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F411D157DB;
	Fri, 29 Apr 2016 13:48:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2GftZipUmNilPR+5vgHWWrgs+CM=; b=qjk6rT
	p5chRL+XWE4zHX+MyCrGw4L9R05Cex8jgWYhiXQiAKFTilFoNEgNfYdZFInHZOuJ
	iPDh53EzDl67sERInzhLSo0nHC9come2UYvpu+zGdGEG/69Ci0PT5wkE059ipkVR
	rcR7uUb6g6W6OS2zUkN9duOM2IsIOQ2fn/Hgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MxGH4LNNb5K21IFSBFBZq1AV8JTpYWIA
	OcRVIe1zWF3k6fa4X+YDJJGyspUBe4tD3Butx+c1LFBvLyoSKEOy7lwEq/0RTVSc
	s8aSzVaCMAWlBhR1DhD//RIQjrCrRX5xx8eoKT3DUVft0CfWvbkzOFbFONJhE9PO
	AU4DYkvTGYo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC645157DA;
	Fri, 29 Apr 2016 13:48:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B507157D2;
	Fri, 29 Apr 2016 13:48:18 -0400 (EDT)
In-Reply-To: <20160429155532.GA57118@google.com> (Brian Norris's message of
	"Fri, 29 Apr 2016 08:55:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E886402-0E32-11E6-81C9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293033>

Brian Norris <computersforpeace@gmail.com> writes:

> I mostly just copied from boilerplate on another option. IIRC, there
> were at least two other options that were documented similarly.

My quick grep didn't find 'another option' other than include.path,
but how about this as a preparatory step?

-- >8 --
Subject: [PATCH] config: describe 'pathname' value type

We have a dedicated section for various value-types used in the
configuration variables already, because we needed to describe how
booleans and scaled integers can be spelled, and the pathname type
would fit there.

Adjust the description of `include.path` variable slightly to
clarify that the variable is of this type.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..64a57fa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -81,13 +81,16 @@ Includes
 
 You can include one config file from another by setting the special
 `include.path` variable to the name of the file to be included. The
+variable takes a pathname as its value, and is subject to tilde
+expansion.
+
+The
 included file is expanded immediately, as if its contents had been
 found at the location of the include directive. If the value of the
 `include.path` variable is a relative path, the path is considered to be
 relative to the configuration file in which the include directive was
-found. The value of `include.path` is subject to tilde expansion: `~/`
-is expanded to the value of `$HOME`, and `~user/` to the specified
-user's home directory. See below for examples.
+found.  See below for examples.
+
 
 Example
 ~~~~~~~
@@ -169,6 +172,13 @@ thing on the same output line (e.g. opening parenthesis before the
 list of branch names in `log --decorate` output) is set to be
 painted with `bold` or some other attribute.
 
+pathname::
+	A variable that takes a pathname value can be given a
+	string that begins with "~/" or "~user/", and the usual
+	tilde expansion happens to such a string: `~/`
+	is expanded to the value of `$HOME`, and `~user/` to the
+	specified user's home directory.
+
 
 Variables
 ~~~~~~~~~
-- 
2.8.1-521-g705491b
