From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 20:52:39 +0200
Message-ID: <004201cd8097$4ef04a80$ecd0df80$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com> <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de> <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com> <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de> <7v628epzia.fsf@alter.siamese.dyndns.org> <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de> <7vy5l9lj6m.fsf@alter.siamese.dyndns.org> <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de> <7v4nnxld24.fsf@alter.siamese.dyndns.org> <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de> <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com> <7vvcga96n9.fsf@alter.siamese.dyndns.org> <003d01cd8090$214ca710$63e5f530$@schmitz-digital.de> <7v393e943x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Brandon Casey'" <drafnel@gmail.com>,
	"'Shawn Pearce'" <spearce@spearce.org>, <git@vger.kernel.org>,
	<rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:53:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4G2x-0001ei-SI
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab2HVSwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:52:50 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:63118 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab2HVSws (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:52:48 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MgYEB-1TGikb090p-00NYyq; Wed, 22 Aug 2012 20:52:47 +0200
In-Reply-To: <7v393e943x.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7EfAdIAjkoB0Br5KAKVWWsnAm8TuDMCb+a+7QMjYLRhAalBYtECWH7b+QJMED4YAf2RaVICOYYBSQI1Vh7UAj8t066VJ3xxAA==
Content-Language: de
X-Provags-ID: V02:K0:DNS5+8PPLHAiEVKLA74SSeDy1v7hTvZM5GsdbQjInPG
 0rKLUcBfAmIvzIPPcMS7ZSu+Ih+zhqKknvbmwb8DnJkImia/XE
 G+jyKl2vWETcY7Qh4l1Wch+UtL4/V6sa7TcO6G6/CNFwY/iaHQ
 qRk9B5s0cgWLi9ayov2D0fCCa77hLvvEIyz+bn8+AK0OnsD1CX
 yE8vLlISUHnuanWiWdEKIU8/3C0+RjTcVQHyq6q16FPYPcy6NC
 L7TvE5mqlcA19ydeVKPYcVUewuyxbiKkEa7aM2/6JA3XxXCCKl
 9vAK0Ql4b9y4PkQkU5l1/saujGbIUsqs1Qo9hn+0nl4V6QJrW6
 cIdyK9HLOT7qRsl+OOobYOyL6G6iiRaJ6SchY4itSgWk3uKgEM
 f33pzmfwQURNA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204067>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Wednesday, August 22, 2012 8:25 PM
> To: Joachim Schmitz
> Cc: 'Brandon Casey'; 'Shawn Pearce'; git@vger.kernel.org;
> rsbecker@nexbridge.com
> Subject: Re: Porting git to HP NonStop
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> Nice.  And we have xmemdupz() would be even better as you followed-up.
> >
> > How's that one used?
> 
> I forgot that we frown upon use of any x<allocate>() wrapper in the
compat/
> layer as J6t mentioned.
> 
> So probably something along these lines...
> 
> 	int retval;
> 	char *dir_to_free = NULL;
> 	size_t len = strlen(dir);
> 
>         if (len && dir[len - 1] == '/') {
> 		dir_to_free = malloc(len);
>                 if (!dir_to_free) {
> 			fprintf(stderr, "malloc failed!\n");
> 			exit(1);
> 		}
>                 memcpy(dir_to_free, dir, len - 1);
>                 dir_to_free[len - 1] = '\0';
>                 dir = dir_to_free;
> 	}
> 	retval = mkdir(dir, mode);
> 	free(dir_to_free);
>         return retval;

So why not just strdup? I stole the idea from gnulib...

int
rpl_mkdir (char const *dir, mode_t mode maybe_unused)
{
  int ret_val;
  char *tmp_dir;
  size_t len = strlen (dir);

  if (len && dir[len - 1] == '/')
    {
      tmp_dir = strdup (dir);
      if (!tmp_dir)
        {
          /* Rather than rely on strdup-posix, we set errno ourselves.  */
          errno = ENOMEM;
          return -1;
        }
      strip_trailing_slashes (tmp_dir);
    }
  else
    {
      tmp_dir = (char *) dir;
    }


They strip more than one trailing slash, but for git's purpose I believed
this to be too much overhead. Also the errno stuff doesn't seem to be really
needed IMHO. Same for the following code

#if FUNC_MKDIR_DOT_BUG
  /* Additionally, cygwin 1.5 mistakenly creates a directory "d/./".  */
  {
    char *last = last_component (tmp_dir);
    if (*last == '.' && (last[1] == '\0'
                         || (last[1] == '.' && last[2] == '\0')))
      {
        struct stat st;
        if (stat (tmp_dir, &st) == 0)
          errno = EEXIST;
        return -1;
      }
  }
#endif /* FUNC_MKDIR_DOT_BUG */

Then it goes on like mine:

  ret_val = mkdir (tmp_dir, mode);

  if (tmp_dir != dir)
    free (tmp_dir);

  return ret_val;
}

Compare:
$ cat compat/mkdir.c
#include "../git-compat-util.h"
#undef mkdir

/* for platforms that can't deal with a trailing '/' */
int compat_mkdir_wo_trailing_slash(const char *dir, mode_t mode)
{
        int retval;
        char *tmp_dir = NULL;
        size_t len = strlen(dir);

        if (len && dir[len-1] == '/') {
                if ((tmp_dir = strdup(dir)) == NULL)
                        return -1;
                tmp_dir[len-1] = '\0';
        }
        else
                tmp_dir = (char *)dir;

        retval = mkdir(tmp_dir, mode);
        if (tmp_dir != dir)
                free(tmp_dir);

        return retval;
}

Bye, Jojo
