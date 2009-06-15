From: Ping Yin <pkufranky@gmail.com>
Subject: A question about using 'add -p' to split the patch
Date: Mon, 15 Jun 2009 11:08:51 +0800
Message-ID: <46dff0320906142008v4f278d3ek3eebfa36f7fcf06a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 15 05:11:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG2bE-0004Mk-Ak
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 05:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbZFODIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 23:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbZFODIu
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 23:08:50 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:47784 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbZFODIu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 23:08:50 -0400
Received: by gxk10 with SMTP id 10so6068329gxk.13
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 20:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=IG1ydfT6yR1IFcHK6jSE9z8i3Jpa8PC8R/cRnI/F618=;
        b=oXVivuWtnmCQsDm9co0E9eo172UImeY5OW0HI+haN3RpspFGCtlwhKoefhOcER+0TB
         v9rQ2TiqIn3k/HogImk2nsbJFYvOvLMh6HWYGHEHmQHA+BTvda5I2YHmJigLTyk0urQM
         tvKyjl0TSMZ2oTGXfU9UYT1jISsT5oClXCeaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=sKqhdbI8xaJsVbhklj1haO40HjD/+3q03iN6HChmAyx6hb34Hg6gczOJRKG0/QwpQO
         lENXM+mi/8Vk0vh/h1s+Ew6LTxItoPFlS9WxTXGbd1KgKGf4158mLcxAyIry77rUQtRG
         utcwLznL9DUDCSaF7/dE8X2aqDGg7NoLb2Kyw=
Received: by 10.90.25.11 with SMTP id 11mr5789584agy.96.1245035331988; Sun, 14 
	Jun 2009 20:08:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121577>

file bt.php in the HEAD:

function bt_add($path) {
 return;
}

file bt.php in the working directory:

function bt_move($path, $pos) {
  return;
}
function bt_add($path, $pos) {
  bt_move($path, $pos)
  return;
}

Now i want to split the change into two parts:
First introduce bt_move
Then add a param pos to bt_add and call bt_move

With the 'e' action of 'add -p', i got

-function bt_add($path) {
+function bt_move($path, $pos) {
+  return;
+}
+function bt_add($path, $pos) {
+  bt_move($path, $pos)
   return;
 }

Then, i want to edit the patch to get


function bt_move($path, $pos) {
  return;
}
function bt_add($path) {
  return;
}

However, whatever i do, the patch fails to apply. Any suggestion?

-


Ping Yin
