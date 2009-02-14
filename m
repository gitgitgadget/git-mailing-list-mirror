From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix wrong base URL when non-root DirectoryIndex
Date: Sat, 14 Feb 2009 03:42:24 +0100
Message-ID: <200902140342.26270.jnareb@gmail.com>
References: <200902122303.37499.jnareb@gmail.com> <200902130945.20601.jnareb@gmail.com> <7vskmh3gtv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 03:43:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYAVZ-0002Zo-Dv
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbZBNCma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbZBNCm3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:42:29 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:47521 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbZBNCm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:42:28 -0500
Received: by fg-out-1718.google.com with SMTP id 16so15069fgg.17
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 18:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=CPiPz30DVAdbbUVJZa7bGIZOhM/fT8r0hHhDMue//u8=;
        b=iEI5ickBOUYGrHlQUlYNd9d1pOHc/ZnX/aZlbRVvK0VKIxuY3vxQxxFmR/kERZWT/Y
         9GAcgVuC7KZNEfVD40MvTLmB6vHp5aM+g7gDJoVTArcZ3k7efLTzJtUQ4cZ+MGTCtr58
         b/mkIR8NlYiGktIbnzGy420WmK3jIeXaWDkLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=X1e3iz6ABgxHwv9cLrP+4TaG8RRr+1fLy2qcnvCyY6B2rEPvj6HQd5YOv665/Rn7KW
         bt4U3ellRpK3P+qZFkOhtiQGOJ0ZiGfHIax+4faSbTKe5kRTfJCC2/VEEOzvBczvtKhA
         q+tKJQahflJ/CKNnzEhzAVsga9gBPsdtbuL44=
Received: by 10.86.29.8 with SMTP id c8mr75791fgc.67.1234579345898;
        Fri, 13 Feb 2009 18:42:25 -0800 (PST)
Received: from ?192.168.1.13? (abwj21.neoplus.adsl.tpnet.pl [83.8.233.21])
        by mx.google.com with ESMTPS id l12sm3940729fgb.41.2009.02.13.18.42.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 18:42:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vskmh3gtv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109808>

On Sat, 14 Feb 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>>
>> Sounds good. I don't use gitweb as DirectoryIndex myself, but
>> Acked-by: Jakub Narebski <jnareb@gmail.com>
>>
>>> +# Another issue with the script being the DirectoryIndex is that the resulting
>>> +# $my_url data is not the full script URL: this is good, because we want
>>> +# generated links to keep implying the script name if it wasn't explicitly
>>> +# indicated in the URL we're handling, but it means that $my_url cannot be used
>>> +# as base URL. Therefore, we have to build the base URL ourselves:
>>> +our $base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
> 
> Breaks t9500 with 
> 
>     [Sat Feb 14 02:12:59 2009] gitweb.perl: Use of uninitialized value in
>     concatenation (.) or string at /pub/git/t/../gitweb/gitweb.perl line 45. 
> 
> Please be more careful when giving an Ack, and more importantly please do
> not send a patch that does not even pass the test suite by itself.

Actually this is not a bug in _gitweb_, but in _test_ itself. 

In t/t9500-gitweb-standalone-no-errors.sh we run gitweb.perl as
a standalone script (not from a web server), and we set _some_ of CGI
environmental variables.  Up till now we could get by using only most
important ones: GATEWAY_INTERFACE (I'm not sure if needed), HTTP_ACCEPT
(used to select Content-Type to use), REQUEST_METHOD (git_feed exits
early on HEAD request), and of course QUERY_STRING and PATH_INFO.
The required variable SCRIPT_NAME is simply not set...

BTW. we could have set also SERVER_NAME, but it is not required by
gitweb (gitweb can deal with situation when it is unset)...

So patch should be squashed with the following improvement to test
suite:

-- >8 --

Additionally t/t9500-gitweb-standalone-no-errors.sh had to be modified
to set SCRIPT_NAME variable (CGI standard states that it MUST be set,
and now gitweb requires it if PATH_INFO is not empty, as is the case
for some of tests in t9500).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 t/t9500-gitweb-standalone-no-errors.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 43cd6ee..7c6f70b 100755
--- i/t/t9500-gitweb-standalone-no-errors.sh
+++ w/t/t9500-gitweb-standalone-no-errors.sh
@@ -43,9 +43,11 @@ gitweb_run () {
 	GATEWAY_INTERFACE="CGI/1.1"
 	HTTP_ACCEPT="*/*"
 	REQUEST_METHOD="GET"
+	SCRIPT_NAME="$TEST_DIRECTORY/../gitweb/gitweb.perl"
 	QUERY_STRING=""$1""
 	PATH_INFO=""$2""
-	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD QUERY_STRING PATH_INFO
+	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD \
+		SCRIPT_NAME QUERY_STRING PATH_INFO
 
 	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
 	export GITWEB_CONFIG
@@ -54,7 +56,7 @@ gitweb_run () {
 	# written to web server logs, so we are not interested in that:
 	# we are interested only in properly formatted errors/warnings
 	rm -f gitweb.log &&
-	perl -- "$TEST_DIRECTORY/../gitweb/gitweb.perl" \
+	perl -- "$SCRIPT_NAME" \
 		>/dev/null 2>gitweb.log &&
 	if grep "^[[]" gitweb.log >/dev/null 2>&1; then false; else true; fi
 

-- 
Jakub Narebski
Poland
