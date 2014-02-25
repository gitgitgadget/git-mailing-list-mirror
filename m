From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] help: include list of aliases in git-help --all
Date: Tue, 25 Feb 2014 23:01:43 -0000
Organization: OPDS
Message-ID: <42F80A3E11EB40DE910D5C71A37AE10C@PhilipOakley>
References: <1393289315-28982-1-git-send-email-joel.nothman@gmail.com><xmqqsir757hy.fsf@gitster.dls.corp.google.com> <CAAkaFLVRP3WF=2hyBo9uxutJ8iLPyBVkiBs=29xN13762r32Bg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Joel Nothman" <joel.nothman@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 00:01:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIR0e-00059i-6q
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 00:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbaBYXBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 18:01:49 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:47681 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753439AbaBYXBr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Feb 2014 18:01:47 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkcZADggDVNZ8YdK/2dsb2JhbABZgwY7iRi4SQEBAgEBgRQXdIIgBQEBBAEIAQEdERYIAQEhBQYCAwUCAQMVAwklFAEECBACBgcXBgEHCwgCAQIDAQwEh1ADCQwJwHwNh0AXjDyCFIMrgRQEiRGGHIccgx+LL4VHgy08
X-IPAS-Result: AkcZADggDVNZ8YdK/2dsb2JhbABZgwY7iRi4SQEBAgEBgRQXdIIgBQEBBAEIAQEdERYIAQEhBQYCAwUCAQMVAwklFAEECBACBgcXBgEHCwgCAQIDAQwEh1ADCQwJwHwNh0AXjDyCFIMrgRQEiRGGHIccgx+LL4VHgy08
X-IronPort-AV: E=Sophos;i="4.97,543,1389744000"; 
   d="scan'208";a="602302973"
Received: from host-89-241-135-74.as13285.net (HELO PhilipOakley) ([89.241.135.74])
  by out1.ip06ir2.opaltelecom.net with SMTP; 25 Feb 2014 23:01:43 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242692>

From: "Joel Nothman" <joel.nothman@gmail.com>
> On 26 February 2014 06:15, Junio C Hamano <gitster@pobox.com> wrote:
>> Joel Nothman <joel.nothman@gmail.com> writes:
>>
>>> Git help --all had listed all git commands, but no configured 
>>> aliases.
>>> This includes aliases as a separate listing, after commands in the 
>>> main
>>> git directory and other $PATH directories.
>>
>> ... and why is this a good thing?
>
> A fair question: I had considered it a conspicuous absence from the
> list of commands in git help.

Surely one alternative would be to add an --alias or --aliases option to 
the help command so the user can chose which ones s/he desires to be 
helped about.

At least that's the way I did it with the --guides option.

>  After all, aliases are treated like
> commands for a few purposes: they are executed as commands, they are
> listed as possible command spelling corrections, and they are valid
> arguments to git help. They are also like commands in that it is
> possible to forget their name, or whether they are defined on a
> particular workstation, and to hence want a listing. A user may also
> not recall whether they had implemented a particular shortcut as an
> alias or as a script (one may initially implement a script, and
> realise an alias is sufficient; one may at first implement an alias
> and realise it is insufficient, and that a script is needed).
>
> In short, for many of the purposes in which one would seek git help
> -a, there is no reason to *exclude* aliases from a list of commands
> executed likewise.
>
>>>
>>> Signed-off-by: Joel Nothman <joel.nothman <at> gmail.com>
>>> ---
>>>  Documentation/git-help.txt |  4 +--
>>>  builtin/help.c             |  7 ++---
>>>  help.c                     | 64 
>>> +++++++++++++++++++++++++++++++++++-----------
>>>  help.h                     |  7 ++++-
>>>  4 files changed, 61 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
>>> index b21e9d7..c9fe791 100644
>>> --- a/Documentation/git-help.txt
>>> +++ b/Documentation/git-help.txt
>>> @@ -40,8 +40,8 @@ OPTIONS
>>>  -------
>>>  -a::
>>>  --all::
>>> -     Prints all the available commands on the standard output. This
>>> -     option overrides any given command or guide name.
>>> +     Prints all the available commands and aliases on the standard 
>>> output.
>>> +     This option overrides any given command or guide name.
>>>
>>>  -g::
>>>  --guides::
>>> diff --git a/builtin/help.c b/builtin/help.c
>>> index 1fdefeb..d1dfecd 100644
>>> --- a/builtin/help.c
>>> +++ b/builtin/help.c
>>> @@ -38,7 +38,7 @@ static int show_guides = 0;
>>>  static unsigned int colopts;
>>>  static enum help_format help_format = HELP_FORMAT_NONE;
>>>  static struct option builtin_help_options[] = {
>>> -     OPT_BOOL('a', "all", &show_all, N_("print all available 
>>> commands")),
>>> +     OPT_BOOL('a', "all", &show_all, N_("print all available 
>>> commands and aliases")),
>>>       OPT_BOOL('g', "guides", &show_guides, N_("print list of useful 
>>> guides")),
>>>       OPT_SET_INT('m', "man", &help_format, N_("show man page"), 
>>> HELP_FORMAT_MAN),
>>>       OPT_SET_INT('w', "web", &help_format, N_("show manual in web 
>>> browser"),
>>> @@ -453,6 +453,7 @@ int cmd_help(int argc, const char **argv, const 
>>> char *prefix)
>>>       int nongit;
>>>       const char *alias;
>>>       enum help_format parsed_help_format;
>>> +     struct cmdnames alias_cmds;
>>>
>>>       argc = parse_options(argc, argv, prefix, builtin_help_options,
>>>                       builtin_help_usage, 0);
>>> @@ -461,8 +462,8 @@ int cmd_help(int argc, const char **argv, const 
>>> char *prefix)
>>>       if (show_all) {
>>>               git_config(git_help_config, NULL);
>>>               printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
>>> -             load_command_list("git-", &main_cmds, &other_cmds);
>>> -             list_commands(colopts, &main_cmds, &other_cmds);
>>> +             load_commands_and_aliases("git-", &main_cmds, 
>>> &other_cmds, &alias_cmds);
>>> +             list_commands(colopts, &main_cmds, &other_cmds, 
>>> &alias_cmds);
>>>       }
>>>
>>>       if (show_guides)
>>> diff --git a/help.c b/help.c
>>> index df7d16d..3c14af4 100644
>>> --- a/help.c
>>> +++ b/help.c
>>> @@ -86,7 +86,7 @@ static void pretty_print_string_list(struct 
>>> cmdnames *cmds,
>>>       int i;
>>>
>>>       for (i = 0; i < cmds->cnt; i++)
>>> -             string_list_append(&list, cmds->names[i]->name);
>>> +         string_list_append(&list, cmds->names[i]->name);
>>>       /*
>>>        * always enable column display, we only consult column.*
>>>        * about layout strategy and stuff
>>> @@ -202,8 +202,48 @@ void load_command_list(const char *prefix,
>>>       exclude_cmds(other_cmds, main_cmds);
>>>  }
>>>
>>> +static struct cmdnames aliases;
>>> +
>>> +static void add_cmd_list(struct cmdnames *cmds, struct cmdnames 
>>> *old)
>>> +{
>>> +     int i;
>>> +     ALLOC_GROW(cmds->names, cmds->cnt + old->cnt, cmds->alloc);
>>> +
>>> +     for (i = 0; i < old->cnt; i++)
>>> +             cmds->names[cmds->cnt++] = old->names[i];
>>> +     free(old->names);
>>> +     old->cnt = 0;
>>> +     old->names = NULL;
>>> +}
>>> +
>>> +static int load_aliases_cb(const char *var, const char *value, void 
>>> *cb)
>>> +{
>>> +     if (starts_with(var, "alias."))
>>> +             add_cmdname(&aliases, var + 6, strlen(var + 6));
>>> +     return 0;
>>> +}
>>> +
>>> +void load_commands_and_aliases(const char *prefix,
>>> +             struct cmdnames *main_cmds,
>>> +             struct cmdnames *other_cmds,
>>> +             struct cmdnames *alias_cmds)
>>> +{
>>> +     load_command_list(prefix, main_cmds, other_cmds);
>>> +
>>> +     /* reuses global aliases from unknown command functionality */
>>> +     git_config(load_aliases_cb, NULL);
>>> +
>>> +     add_cmd_list(alias_cmds, &aliases);
>>> +     qsort(alias_cmds->names, alias_cmds->cnt,
>>> +               sizeof(*alias_cmds->names), cmdname_compare);
>>> +     uniq(alias_cmds);
>>> +     exclude_cmds(alias_cmds, main_cmds);
>>> +     exclude_cmds(alias_cmds, other_cmds);
>>> +}
>>> +
>>>  void list_commands(unsigned int colopts,
>>> -                struct cmdnames *main_cmds, struct cmdnames 
>>> *other_cmds)
>>> +                struct cmdnames *main_cmds, struct cmdnames 
>>> *other_cmds,
>>> +                struct cmdnames *alias_cmds)
>>>  {
>>>       if (main_cmds->cnt) {
>>>               const char *exec_path = git_exec_path();
>>> @@ -219,6 +259,13 @@ void list_commands(unsigned int colopts,
>>>               pretty_print_string_list(other_cmds, colopts);
>>>               putchar('\n');
>>>       }
>>> +
>>> +     if (alias_cmds->cnt) {
>>> +             printf_ln(_("aliases defined in git configuration"));
>>> +             putchar('\n');
>>> +             pretty_print_string_list(alias_cmds, colopts);
>>> +             putchar('\n');
>>> +     }
>>>  }
>>>
>>>  void list_common_cmds_help(void)
>>> @@ -248,7 +295,6 @@ int is_in_cmdlist(struct cmdnames *c, const char 
>>> *s)
>>>  }
>>>
>>>  static int autocorrect;
>>> -static struct cmdnames aliases;
>>>
>>>  static int git_unknown_cmd_config(const char *var, const char 
>>> *value, void *cb)
>>>  {
>>> @@ -270,18 +316,6 @@ static int levenshtein_compare(const void *p1, 
>>> const void *p2)
>>>       return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
>>>  }
>>>
>>> -static void add_cmd_list(struct cmdnames *cmds, struct cmdnames 
>>> *old)
>>> -{
>>> -     int i;
>>> -     ALLOC_GROW(cmds->names, cmds->cnt + old->cnt, cmds->alloc);
>>> -
>>> -     for (i = 0; i < old->cnt; i++)
>>> -             cmds->names[cmds->cnt++] = old->names[i];
>>> -     free(old->names);
>>> -     old->cnt = 0;
>>> -     old->names = NULL;
>>> -}
>>> -
>>>  /* An empirically derived magic number */
>>>  #define SIMILARITY_FLOOR 7
>>>  #define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
>>> diff --git a/help.h b/help.h
>>> index b21d7c9..3939bc6 100644
>>> --- a/help.h
>>> +++ b/help.h
>>> @@ -21,11 +21,16 @@ extern const char *help_unknown_cmd(const char 
>>> *cmd);
>>>  extern void load_command_list(const char *prefix,
>>>                             struct cmdnames *main_cmds,
>>>                             struct cmdnames *other_cmds);
>>> +extern void load_commands_and_aliases(const char *prefix,
>>> +                           struct cmdnames *main_cmds,
>>> +                           struct cmdnames *other_cmds,
>>> +                           struct cmdnames *alias_cmds);
>>>  extern void add_cmdname(struct cmdnames *cmds, const char *name, 
>>> int len);
>>>  /* Here we require that excludes is a sorted list. */
>>>  extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames 
>>> *excludes);
>>>  extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
>>> -extern void list_commands(unsigned int colopts, struct cmdnames 
>>> *main_cmds, struct cmdnames *other_cmds);
>>> +extern void list_commands(unsigned int colopts, struct cmdnames 
>>> *main_cmds,
>>> +                       struct cmdnames *other_cmds, struct cmdnames 
>>> *alias_cmds);
>>>
>>>  /*
>>>   * call this to die(), when it is suspected that the user mistyped 
>>> a
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
