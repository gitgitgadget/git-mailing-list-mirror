From: Sam Vilain <sam@vilain.net>
Subject: Re: The Reposithon!  Take 2 [URL FIX]
Date: Tue, 18 Dec 2007 01:00:43 +1300
Message-ID: <476664EB.5030500@vilain.net>
References: <47664617.9010106@vilain.net> <4766582F.4030207@vilain.net> <20071217111433.GN23703@plum.flirble.org> <4766620A.6050704@vilain.net> <20071217115450.GR23703@plum.flirble.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Perl 5 Porters <perl5-porters@perl.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicholas Clark <nick@ccl4.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4FA2-0005ys-40
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 13:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbXLQMdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 07:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXLQMdE
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 07:33:04 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:47055 "EHLO
	musashi.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbXLQMdB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 07:33:01 -0500
X-Greylist: delayed 1793 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2007 07:33:01 EST
Received: by musashi.utsl.gen.nz (Postfix, from userid 1003)
	id 37B7321D068; Tue, 18 Dec 2007 01:03:07 +1300 (NZDT)
FCC: imap://sam@mail.utsl.gen.nz/INBOX/Sent
X-Identity-Key: id1
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20071217115450.GR23703@plum.flirble.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68556>

Nicholas Clark wrote:
> On Tue, Dec 18, 2007 at 12:48:26AM +1300, Sam Vilain wrote:
>> Nicholas Clark wrote:
>>> error: Could not interpret The page was, like, not found and stuff. as something to pull
>>>
>>>
>>>                            ^ random capitalisation or missing punctuation
>>>                                          ^ slang interjection
>>>                                                          ^ slang interjection
>>>                                                                     ^ missing capitalisation
>>>
>> I've never had my server 404 message
>>
>>   http://utsl.gen.nz/err/404.html
>>
>> So well critiqued!  Thanks!  :-)
>>
>> Hopefully all the pull problems should be sorted now.
> 
> I remain unhappy that git does not tell me that it's reporting a 404 error.
> 404 makes sense in any language. What the server admin chooses as the
> accompanying page may well not, although usually it would be because he or
> she chooses to make it report errors in the local language.

meh.  look, actually tell you what my little web server is returning the
wrong error HTTP response code.  Which is a pretty stupid
misconfiguration and not one you'd see very often.  So the data gets a
little further in before it is noticed to be wrong.

The error message isn't the best, no.

Junio, any chance of this going in?

Subject: Clarify error response from 'git fetch' for bad responses

This error message prints the reponse from the server at this point.
Label it as such in the output.
---
 walker.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/walker.c b/walker.c
index 397b80d..adc3e80 100644
--- a/walker.c
+++ b/walker.c
@@ -274,7 +274,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 
 	for (i = 0; i < targets; i++) {
 		if (interpret_target(walker, target[i], &sha1[20 * i])) {
-			error("Could not interpret %s as something to pull", target[i]);
+			error("Could not interpret response from server '%s' as something to pull", target[i]);
 			goto unlock_and_fail;
 		}
 		if (process(walker, lookup_unknown_object(&sha1[20 * i])))
