From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: sha-1 check in rev-list --verify-objects redundant?
Date: Sun, 26 Feb 2012 00:15:19 +0700
Message-ID: <CACsJy8D_BdV14dGc2YsK91FrX8S=70DJOY3cU=oH3y41N2Ar0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 18:16:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1LEQ-0006XA-8f
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 18:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879Ab2BYRPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 12:15:52 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:61472 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756840Ab2BYRPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 12:15:51 -0500
Received: by wibhm11 with SMTP id hm11so541692wib.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 09:15:50 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) client-ip=10.180.99.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.99.65])
        by 10.180.99.65 with SMTP id eo1mr5376558wib.13.1330190150256 (num_hops = 1);
        Sat, 25 Feb 2012 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=w7JsD4NLWbs/6621qrNrM50TNaq4anj5OpBznrmZYVk=;
        b=jGPORteIPJaWGp08D88BbvP4wVXQorZhbgjubUE9AQFufHj5GQsvX1+BHtV9lU+sPb
         CMFfhtWwXAzMaPLosMYeAlwlITbhWrg9i3H89Vboit6gVsI62TXTvGQ5gql2E6KKGozt
         +DqhCrQRRtSJXtwcYBZJhTJmGWzxFMPqRKysE=
Received: by 10.180.99.65 with SMTP id eo1mr4245314wib.13.1330190150196; Sat,
 25 Feb 2012 09:15:50 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Sat, 25 Feb 2012 09:15:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191538>

Hi,

"git rev-list --verify-objects" calls parse_object() on all except
commits. This function in turn does check_sha1_signature() which
rehashes object content to verify the content matches its sha-1
signature. This is an expensive operation. I wonder if this is a
redundant check. --verify-objects is called to verify new packs.
index-pack is also (always?) called on new packs, and index-pack
hashes all object content, saves the hashes as signature in pack index
file. So they must match. Am I missing something here?
-- 
Duy
