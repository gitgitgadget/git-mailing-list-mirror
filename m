From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: Ignoring boring lines(that do not contain information) in git
 diff
Date: Mon, 26 Nov 2012 21:35:38 +0100
Message-ID: <50B3D29A.2070805@arcor.de>
References: <507302DC.4030207@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 21:35:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5PI-0007mk-Gh
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab2KZUfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:35:41 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:41240 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754863Ab2KZUfk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2012 15:35:40 -0500
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])
	by mx.arcor.de (Postfix) with ESMTP id 4135F10890C
	for <git@vger.kernel.org>; Mon, 26 Nov 2012 21:35:39 +0100 (CET)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id 3F35710C029
	for <git@vger.kernel.org>; Mon, 26 Nov 2012 21:35:39 +0100 (CET)
Received: from [10.0.0.2] (188-22-34-229.adsl.highway.telekom.at [188.22.34.229])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-14.arcor-online.net (Postfix) with ESMTPA id 06A0513B625
	for <git@vger.kernel.org>; Mon, 26 Nov 2012 21:35:38 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-14.arcor-online.net 06A0513B625
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1353962139; bh=zc/3UcTb3OE2HUj48PLdhC49RMWBh+YdnyjYq8B84l8=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=dRxYIwJyH/efXEIGAoLLBYY2piiLiK8YUAVjaBjUqv0Hp/XCx2WPMQ+h7GUeROb8E
	 QKTPG2QFnMQQsvWytx9IwhwY62V0PRUpOMLm8V1ck4It4+QvpPABGY1CpR3o3LUqgP
	 k+/3A/NYKXtppVUlCoM1i69LjGGqYidAOmiYFxHg=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <507302DC.4030207@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210481>

On 2012-10-08 18:44, Peter Oberndorfer wrote:
> Hi,
>
> is there a way to tell git diff about lines that are uninteresting?
> I mean lines which do not contain a lot of information and
> appear several times in pre and post image.
>
> For example whitespace or language dependent stuff like.
> {
> }
> END_IF;
> END_FOR;
> end sub
>
> I have seen diffs that containing 2 interesting hunks splitted by such boring lines.
> (I have attached a anonymized version of a real world example where this happens)
>
> I think the diff would be clearer when this boring line was added to the surrounding hunks.
> I already tried patience diff but in my test case it changed nothing.
> I am using git 1.7.10.
>

Hi,

does anybody have a idea if this is possible?
Or some comments if they would find such a feature useful?

Greetings Peter


example_diff_boring_split.diff

diff --git a/Source/Frobble/Blabber.txt b/Source/Frobble/Blabber.txt
index 87ccddb..627bc3e 100644
--- a/Source/Frobble/Blabber.txt
+++ b/Source/Frobble/Blabber.txt
@@ -138,73 +138,74 @@ END_VAR
-         //frobble immediately if immediately flag is set
-         IF bImmediately AND NOT Array[i].bDisabled THEN
-            aFrobble(i, Entry);
+         IF Entry.bBlah THEN
+               Alarm.Alarm  := SomeAlarm;
+         ELSE
+               Alarm := Entry;
          END_IF;
-         // signal if frobble count has changed
-         iChanged := iChanged + 1;
-         EXIT;
+         IF Array[i].Alarm = Alarm THEN
+            //do not brabble if alarm is gobbled
+               EXIT;
+         END_IF;
       END_IF;
-   END_FOR;
-ELSE
-   aExample(Name := 'aaa',
-            ID1 := 1);
-END_IF;
+   ELSE
+      //entry not found, adding
