From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] help: mark common_guides[] as translatable
Date: Fri, 12 Apr 2013 17:16:30 +0100
Organization: OPDS
Message-ID: <76E75C159EF54DD4A26051735FA370C8@PhilipOakley>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org> <1364942392-576-5-git-send-email-philipoakley@iee.org> <20130412135142.GA29454@ruderich.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	"David Aguilar" <davvid@gmail.com>
To: "Simon Ruderich" <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:16:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQgeS-0000SF-0L
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484Ab3DLQQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:16:32 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:39983 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754027Ab3DLQQb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Apr 2013 12:16:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtYNAM8yaFFZ8Yth/2dsb2JhbABQgwY2iG24agQBAwGBCxd0ghoFAQEEAQgBAS4eAQEhCwIDBQIBAxUBAgklFAEEGgYHFwYTCAIBAgMBA4d6Cr0Aji1fC4JnYQOIS4V0iWSIV4cZgww7
X-IronPort-AV: E=Sophos;i="4.87,462,1363132800"; 
   d="scan'208";a="424858867"
Received: from host-89-241-139-97.as13285.net (HELO PhilipOakley) ([89.241.139.97])
  by out1.ip02ir2.opaltelecom.net with SMTP; 12 Apr 2013 17:16:29 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220997>

From: "Simon Ruderich" <simon@ruderich.org>
Sent: Friday, April 12, 2013 2:51 PM
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
> On Tue, Apr 02, 2013 at 11:39:51PM +0100, Philip Oakley wrote:
>> --- a/help.c
>> +++ b/help.c
>> @@ -240,6 +241,23 @@ void list_common_cmds_help(void)
>>  }
>>  }
>>
>> +void list_common_guides_help(void)
>> +{
>> + int i, longest = 0;
>> +
>> + for (i = 0; i < ARRAY_SIZE(common_guides); i++) {
>> + if (longest < strlen(common_guides[i].name))
>> + longest = strlen(common_guides[i].name);
>> + }
>> +
>> + puts(_("The common Git guides are:\n"));
>> + for (i = 0; i < ARRAY_SIZE(common_guides); i++) {
>> + printf("   %s   ", common_guides[i].name);
>> + mput_char(' ', longest - strlen(common_guides[i].name));
>> + puts(_(common_guides[i].help));
>
> common_guides[] is used here, but without N_() not picked up by
> xgettext when creating the pot file.

Yes. I mucked that up when I hacked the generate-cmdlist.sh to create 
this list.

Acked-by: Philip Oakley <philipoakley@iee.org>

At some point it is on my TODO list to extend the guide list mechanism 
to all the community generated guides (option -gg) by extending the 
command-list.txt file and the shell script.

>
> Regards
> Simon
>
> builtin/help.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 034c36c..062957f 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -419,13 +419,13 @@ static struct {
>  const char *name;
>  const char *help;
> } common_guides[] = {
> - { "attributes", "Defining attributes per path" },
> - { "glossary", "A Git glossary" },
> - { "ignore", "Specifies intentionally untracked files to ignore" },
> - { "modules", "Defining submodule properties" },
> - { "revisions", "Specifying revisions and ranges for Git" },
> - { "tutorial", "A tutorial introduction to Git (for version 1.5.1 or 
> newer)" },
> - { "workflows", "An overview of recommended workflows with Git"},
> + { "attributes", N_("Defining attributes per path") },
> + { "glossary", N_("A Git glossary") },
> + { "ignore", N_("Specifies intentionally untracked files to 
> ignore") },
> + { "modules", N_("Defining submodule properties") },
> + { "revisions", N_("Specifying revisions and ranges for Git") },
> + { "tutorial", N_("A tutorial introduction to Git (for version 1.5.1 
> or newer)") },
> + { "workflows", N_("An overview of recommended workflows with 
> Git") },
> };
>
> static void list_common_guides_help(void)
> -- 
> 1.8.2.481.g0d034d4
>
> -- 
> + privacy is necessary
> + using gnupg http://gnupg.org
> + public key id: 0x92FEFDB7E44C32F9
