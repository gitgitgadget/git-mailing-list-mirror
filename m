From: Duy Nguyen <pclouds@gmail.com>
Subject: pack negotiation algorithm between 2 share-nothing repos
Date: Wed, 12 Aug 2015 18:27:24 +0700
Message-ID: <CACsJy8AKKYux6w=6X392mJhGFfqfEvJsrX0PjcivHPt2PYVKAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 13:28:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPUCM-0006IH-QP
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 13:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbbHLL1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 07:27:55 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33060 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbbHLL1y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 07:27:54 -0400
Received: by iods203 with SMTP id s203so16346087iod.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 04:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=vG8xpzqFcxAOmLQKnwTX5hCGZf9xImAi+fzvNGAxB+o=;
        b=mlXCUQmJ0bhfBTvSo9MP5H71iEXTXcZ0ITkRj0UsC/2IHqNP2gMrl4WxlesVP8G7EB
         /KOg61KJSMJq2Z0ZTHM4fXk7iXUjZ2LhN3y6P3omUNRr4NSjNH6IGjKhKLUjVxC+3Njp
         qkNsRZuEVlPb5jMLy60PSv+gpt23aJ9kz+owCX0RUVOyaJIBVTI/FtJmGrnXlK4/t4JT
         QrGgHW3r3StX92+ApmGanURWfKA/PA9rTO8P0TJbLJbVpV01NihLstIxRTXMD/dlIdmV
         thpi/MREGUCuvK9jrWntRBdcRhYR6FIHiqtYuiurIHwU6ndJwfIkYWXI/lZ+A35bNwV2
         bcjA==
X-Received: by 10.107.9.11 with SMTP id j11mr20656346ioi.191.1439378873625;
 Wed, 12 Aug 2015 04:27:53 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Wed, 12 Aug 2015 04:27:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275760>

This is a corner case that has a real use case:

git clone linux-2.6.git
cd linux-2.6
git remote add history git-history.git
git fetch history
# graft graft graft

Because history.gi and linux-2.6.git have nothing in common, the
server side keeps asking for more "have"s and the client keeps sending
in "git fetch history". Negotiation phase takes longer than my
patience so I abort it, hack git to send no "have"s and retry.

I know this is a corner case, but because it has a valid use case,
maybe we should do something about it. Immediate reaction is to add an
option to send no "have"s. But maybe you guys have better ideas.

PS. I know i'm behind my git inbox. Looking into it soon.
-- 
Duy
