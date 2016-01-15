From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v11] ls-files: add eol diagnostics
Date: Fri, 15 Jan 2016 05:51:35 +0100
Message-ID: <56987AD7.2050707@web.de>
References: <1452788241-9879-1-git-send-email-tboegi@web.de> <xmqqr3hkj6q1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Fri Jan 15 05:51:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJwMc-0000Zu-Mk
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 05:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbcAOEvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 23:51:51 -0500
Received: from mout.web.de ([212.227.17.11]:54088 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbcAOEvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 23:51:50 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LzKEH-1a729G3vXd-014VQO; Fri, 15 Jan 2016 05:51:44
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqqr3hkj6q1.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:NBw0VDE/gNsEca5fy/4jVocMkVPR8taPSYwOm19/iJfi7b54s/k
 OphMCd11c3+8EiCnLw2mJH9WesWE+lHB35/hjgN/pkyJlj+wrYmBEmA08A2B4IXToj9mFeK
 bRqSQTx7+QisR7Bw8SfV0y9mG3chxcmTl9EZ8OxMvOZW3JPnPmLw2M55Q0fgkbbLPAvPjUK
 DXrXqjLJGingyX8AubOrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XEyPuBwcwp8=:4UqaTRGolzOPw7L20SXfHs
 kHBHGt98bY25Ad3jX/M24rEeICvBUOju+oW7z2YxhBXYxFce3fVb+ltGs3ztKK5FtGw0DRqTq
 WM6LRMgdql/7gGPVLouVmjWv3G9DBEaScVu0eermlPchqal9ASXBgHUktSlYZ/bARYYNXHXFJ
 6AOZOyS6w0WKTDbyRNMNb4voNNWcg3aLYqEqcJhWnML1ZkmQvyLup9dqXWQ1qyQwREhULT1AU
 15IGRH0OgZCgcTOZJAALBIL5Wnqgq+bxO93xTXDURkg85YMGeY5ozolJGrIZfGirhZQrtTZqV
 nZ76kJP9EzxvGqEEeaXIEc8W8SXVnPDnocOis5ggX8c4gS94ITHb/7wxHmru/+4+wRCtCiZl7
 u0wX7JApdVnxROwIHj8iguAWdC+cY90PhSOJBTO5PRFLL/31PgPeQAllNcgwDklRxZgwe9TsI
 oH09BIb2RuUEgNnqKE/LRFlSW0WBZyIYdEeB6csZ7S1uWBJN3+CfesgLiBe0r55yfvh1QK7Ng
 qPfx96xPfB5FKBf8PwgNiM1NWpUeP19Dlzk5SWxccwRwHiSvNvrnprZ1IQ4ueWSjr1TBiYXB8
 je2yG60HwFk/6C5BAUJmmqE1DNMCQT4GFm7dO92Xe0oEk3VbT0Rb+lCi+5id99Lmdw47AJI5t
 DBG2lMyJbuOlohAh7lydGYsZZ6NNKb75lQMCX00ubs3/NcNkNZEmPNHYzB51wCxYj3cy12bRp
 AAPc15ZySpmcuqlpYFjlimnx9x0PDolIVKnfCwyRoXjUlKBmnLvasJOCeZRAQMrkzJadSMQ4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284134>

On 01/14/2016 08:34 PM, Junio C Hamano wrote:
(OK with the rest of the comments, thanks)
> +		return "binary";
> It is true and correct that we do not do EOL conversion on text
> files that have a lone CR, but I think it is misleading to tell the
> users that such files are "binary".  We do not refrain from showing
> the textual diff for such files, for example.
>
> To put it another way, we do not do EOL conversion for truly
> 'binary' files, but there are (mostly) text files that are not
> binary that we do not do EOL conversion on.  And you want to tell
> the user if EOL conversion would happen to each file.  It is not
> correct to label "this file is binary" merely because you do not do
> EOL conversion.  Perhaps define a new "literal" class that is a
> superset of "binary" and use that as the label?  I am not suggesting
> that "ls-files --eol" should show "i/binary" for truly binary files
> and "i/literal" for a non-binary file with lone CRs.  For the
> purpose of "--eol", you only care about "literal", so you do not
> even have to have "binary" class at all.
This makes sense, how about "-text" ?
