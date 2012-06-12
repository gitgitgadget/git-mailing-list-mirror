From: Simon Perrat <simon.perrat@ensimag.imag.fr>
Subject: Re: [PATCHv3 4/6] Tests for git-remote-mediawiki pull
Date: Tue, 12 Jun 2012 15:58:51 +0200
Message-ID: <CA+hdvHgz0EFXMk2C9SA2AnDeeh9i8Eo7WPdYvkotLEN8og892A@mail.gmail.com>
References: <4FD654C8.6040208@ensimag.imag.fr> <1339446526-22397-1-git-send-email-simon.cathebras@ensimag.imag.fr>
 <1339446526-22397-4-git-send-email-simon.cathebras@ensimag.imag.fr> <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Simon Cathebras <simon.cathebras@ensimag.imag.fr>,
	git@vger.kernel.org, Matthieu Moy <matthieu.moy@imag.fr>,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	charles.roussel@ensimag.imag.fr, gitster@pobox.com, peff@peff.net
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Tue Jun 12 15:59:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeRcs-0001JF-5R
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 15:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab2FLN7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 09:59:14 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63116 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab2FLN7N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 09:59:13 -0400
Received: by obbtb18 with SMTP id tb18so8343467obb.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JXMQ09nzH3OXiTR46DHr2tvihef7exKCu4JpCn2Tom8=;
        b=EgmHF1FibrVPpFAQtIkhMkv2PEmdiDmgYCpF5hnXmtGw053VfCPutO4xp9z87HhMYt
         YmdQ9ZYIaGB5Jqnc5kH97SxQAxCJHlCGZdylYpMZI60Rj+Ow9wl9darFXwPHpKuZdNAs
         LtTeMb7szzXmogJP1WNRep4TEq+QX2I7l0jOj0I9/uKntoNLhD+qQRDcIOE8RIrI2Jzb
         2ivkSiaUw+tRnIUaoI4zlKEJCCN9d4yvyOzbOh/B7KIXk8auj+r+b6LevUOT5Ur7yuxT
         /XtkkbofmTm5y8FsxFXbgMjrZtXGUNthpqfTtHh8+iksCtwNEIbFWrke/1t8xt20UJrT
         1lcg==
Received: by 10.182.149.9 with SMTP id tw9mr21054907obb.45.1339509552098; Tue,
 12 Jun 2012 06:59:12 -0700 (PDT)
Received: by 10.60.169.107 with HTTP; Tue, 12 Jun 2012 06:58:51 -0700 (PDT)
In-Reply-To: <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr>
X-Google-Sender-Auth: CSbeXhPqVaoPnkf3VPfsex42Jq4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199785>

2012/6/11  <konglu@minatec.inpg.fr>:
>
> Simon Cathebras <simon.cathebras@ensimag.imag.fr> a =E9crit=A0:
>
>
>> +test_expect_success 'Git pull works after adding a new wiki page' "
>> + =A0 =A0 =A0 =A0wiki_reset &&
>> + =A0 =A0 =A0 cd $TRASH_DIR &&
>> + =A0 =A0 =A0 rm -rf mw_dir &&
>> + =A0 =A0 =A0 rm -rf ref_page &&
>> +
>> + =A0 =A0 =A0 =A0git clone mediawiki::http://$SERVER_ADDR/$WIKI_DIR_=
NAME mw_dir &&
>> + =A0 =A0 =A0 =A0wiki_editpage Foo \"page created after the git clon=
e\" false &&
>> +
>> + =A0 =A0 =A0 =A0cd mw_dir &&
>> + =A0 =A0 =A0 =A0git pull &&
>> + =A0 =A0 =A0 =A0cd .. &&
>> +
>> + =A0 =A0 =A0 =A0rm -rf ref_page &&
>> + =A0 =A0 =A0 =A0wiki_getallpage ref_page &&
>> + =A0 =A0 =A0 =A0test_diff_directories mw_dir ref_page &&
>> + =A0 =A0 =A0 =A0rm -rf ref_page &&
>> + =A0 =A0 =A0 =A0rm -rf mw_dir
>> +"
>
>
> Why are there dquotes here (and all the following tests) ? You used
> simple quote in t9360.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

We corrected this to use simple quotes in all our tests; originally we
used double quotes because of $ in the scripts, now we're escaping
them.
