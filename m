From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 15/16] index-helper: optionally automatically run
Date: Sun, 17 Apr 2016 12:19:55 +0700
Message-ID: <CACsJy8C8un8AAwr5OWX6b8+ync=hqe3JLb=zNMN947oDLmZo4w@mail.gmail.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com> <1460507589-25525-16-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.co>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 07:20:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arf8a-0003DO-IZ
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 07:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbcDQFU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 01:20:29 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35980 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbcDQFU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 01:20:27 -0400
Received: by mail-lf0-f51.google.com with SMTP id g184so184718158lfb.3
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 22:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aEo/2bdFUopUynUmhOwxq+olVCfnIJss0NhZKnplB+g=;
        b=AgBNKogT5ShjfE4z58u6ppLITxjmb5ui9zKjgE+RANDVjZSHGBfAFhpTE85vlYRKCQ
         s7+6qJ4dxQBWIlNzN0GZeCpue1xXMHOF85gAp44M2cIgdJ2Lnu0eko5u1UTmo27ZTxJF
         rl8kckGDWo9lFDNnYtz7wZXgxVqxd/uoc17SN53KBlbFYZsYLjtH5Ao84Gp/cQO9Kj/t
         WHrD1lEkFT5KbQcseitYN/hvSGL4xD2VHwLd7HzqkmkvytHWVcizOKav+PckrNgXTwPt
         AfYGdI33dDmPmJph3muPtqcOGt/15Q7A1+p4+xL0xSNC6A72enynZRt4zVH+E2hJmQO5
         3lgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aEo/2bdFUopUynUmhOwxq+olVCfnIJss0NhZKnplB+g=;
        b=f1yGVC0lwUvwUJsbQ6nixkecuKKZf5EtHyTvVFjiiWqAsNBNibXAUhtsV+tTpq+qlg
         swvJopghQOb0ytwr/AnBF7VHCz1zvx73975JGJes8rH04YjsCYNbLwNx4ww3eGf+136X
         zmAhAn6JZtpAg/iPmA8ZsgBfIp6bH8897jdDKatweRksYouaWOPMrP0kLjwWorO4kvPy
         0iNeNHEDCmemy5C1DGLGiX8PD3cfxKiRO3ssedFqsumyfNOowDMr6ZLdCL0wD7lGg1M+
         FuTqhccg3mwv4KqB79eNehxo5lUgSyGJfYKu8d+RWkgNVH+2BxsfSKxmSW6Y59Nk6r08
         m3Dw==
X-Gm-Message-State: AOPr4FWJcqj3v1RD1ZBDo3aaXViz398L5uasfIPnAkECiFKvKaKngnmhk1CIskYEe6VVUYqbk3vVR2uGeSjrLQ==
X-Received: by 10.112.85.43 with SMTP id e11mr12989211lbz.80.1460870425012;
 Sat, 16 Apr 2016 22:20:25 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Sat, 16 Apr 2016 22:19:55 -0700 (PDT)
In-Reply-To: <1460507589-25525-16-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291743>

On Wed, Apr 13, 2016 at 7:33 AM, David Turner <dturner@twopensource.com> wrote:
> @@ -536,8 +567,10 @@ static void handle_builtin(int argc, const char **argv)
>         }
>
>         builtin = get_builtin(cmd);
> -       if (builtin)
> +       if (builtin) {
> +               maybe_run_index_helper(builtin);
>                 exit(run_builtin(builtin, argc, argv));
> +       }
>  }

Isn't it too early to start index-helper here? Unrelated commands like
git-log are affected. And config handling this early could be tricky.
A better place may be in the socket connection code. When we fail to
connect, we can check config key and run index-helper then.
-- 
Duy
