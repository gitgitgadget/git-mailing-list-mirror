From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] merge-file: correctly open files when in a subdir
Date: Mon, 9 Feb 2015 17:06:37 +0700
Message-ID: <CACsJy8Abyi00UeDBWCoz6_+KE=k1-KkZCw8yww_g2pWbB+RYqg@mail.gmail.com>
References: <CAPHKiG7yP=QZBVdDbyQp=uyMX0EsmUqgO-LO8pscn7hcbP0RCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Aleksander Boruch-Gruszecki <aleksander.boruchgruszecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 11:07:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKlFM-00053y-HM
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 11:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760387AbbBIKHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 05:07:09 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:55088 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759967AbbBIKHI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 05:07:08 -0500
Received: by mail-ig0-f182.google.com with SMTP id h15so15196721igd.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 02:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UqY0xjWiMb2uJw5N7tllM7zYBYg9zWdm1Rdq7lbuvZI=;
        b=yqpjq51OoBenZOko6M5972SF0Ww9Aho8ExbhbeHQLIhJC/zDCXysE0RfOdIFijWqwB
         auBNLA/wSEdSqRWP2KhogqG2sVO07uGEEGb8vv8n2me2xx20HhVrwq7SNzfhll01gT3N
         sjqaPncpBffJwxDRpNLpsYUzOXVBy469xzcXZ/4sqX5oacZPdulCGi4MPpPL2qPxJ7ZE
         bf3hUZ9eBKrWAxF6yL84CWoHJs5jUxpsg1NTbprxJ0oK/4/yb2TM3AlurKagLPOkyI/V
         yMArCMUN8zj6fyeFBMdQvH8HTiyplWeHKdxYHWTQYlTLdYDLsS4lR/MCJItSMAA1hKDB
         EqBA==
X-Received: by 10.107.133.142 with SMTP id p14mr24660954ioi.31.1423476428101;
 Mon, 09 Feb 2015 02:07:08 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 9 Feb 2015 02:06:37 -0800 (PST)
In-Reply-To: <CAPHKiG7yP=QZBVdDbyQp=uyMX0EsmUqgO-LO8pscn7hcbP0RCw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263559>

On Sun, Feb 8, 2015 at 11:53 PM, Aleksander Boruch-Gruszecki
<aleksander.boruchgruszecki@gmail.com> wrote:
> run_setup_gently() is called before merge-file. This may result in changing
> current working directory, which wasn't taken into account when opening a file
> for writing.
>
> Fix by prepending the passed prefix. Previous var is left so that error
> messages keep referring to the file from the user's working directory
> perspective.

Sounds about right. Thomas Rast fixed something similar in 55846b9
(merge-file: correctly find files when called in subdir - 2010-10-17)
but he missed this part :-D. Perhaps a test case in
t/t6023-merge-file.sh to prove this patch is working?
-- 
Duy
