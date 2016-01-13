From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH v2 4/4] t0060: verify that basename() and dirname() work
 as expected
Date: Wed, 13 Jan 2016 10:52:38 -0800
Message-ID: <CAO2U3QjYukb4mB414mVLX2=CxLPBnDaUyDRsfitE_bTZv8_zFQ@mail.gmail.com>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
 <cover.1452270051.git.johannes.schindelin@gmx.de> <eca740dbf6271bd69f2ccb14163175996ef7c837.1452270051.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 19:57:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQbo-00075p-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 19:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757056AbcAMS5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 13:57:14 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34009 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797AbcAMSw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:52:58 -0500
Received: by mail-ig0-f174.google.com with SMTP id ik10so178849065igb.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 10:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r5JNtfMVncgIfKw3xgwYBdgrbrEnBuq1MfuKa38yoOI=;
        b=puAonK0PC4/SdOYsQ7fm2JvpfH7R/DweS6n94o5l9GRV/+hpOj9BSZBoajYNssjA8m
         irM6Uv64GinZyku4tLSHsq+LT/v+YP7fIjGNGI/BwZx5HSBY5iPjYJVTnbf611NLvawg
         l//eySC4W7XNSnC1ra/XtJZTaiVz9sMBN/rDb8nf594HCWePrEn+x/jPmLvPns9OZAcR
         WhmsaifbYXRiVk6Ie3YtmH88+UqLW3Tlpk92DwpExO12OVUqSz/qdnvdyRrfWoeYdI0f
         0k3Mpa7WjkjsBjyyKykxaN0kqXNvRBQN53Ry7Hwa+nCvJKFAgiot2LxMTJf7btuMZlo4
         mGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=r5JNtfMVncgIfKw3xgwYBdgrbrEnBuq1MfuKa38yoOI=;
        b=NeHov0Rm0HoYcO/jdItUQF4Ta46ZAtiYBgz2xfKh3pom09ZSPhnj7gDZc0vB2tSgEP
         9PmsB9JCqaR2obWFbI33GML1jEvkaFcj3R5ynMYkPQZ/ORW2+K9bF/yuHYiG7LY0eehM
         wIz5/RxuSczq8ql5t9nfw6UCRYNUC4tZLchr/wZQa4Q1hOwvlEh3ChQ/Uu+Kva48kTxI
         ItFbytEp6Sv4RegMsFa6K3XlAVLlNFSqeTzJbggI9JmVGu9pahPB15LrZ3SgRzNRU2TX
         K6tBYFWofi2Ogiyc6B8AqPqOguIRiPg8voEdbKK4n9FO7vbHHm9Dqbi+lQBzz3JJZyT2
         sBRA==
X-Gm-Message-State: ALoCoQmM0Rr80pUz0+eDYNjg4TJadW6inpU9BHPPsxaHA9PReWLJ8vxvZj7slMUrBRkjJMTtFqA9sY1N2upcP7lMezs+fPMrWQ==
X-Received: by 10.50.102.40 with SMTP id fl8mr408465igb.85.1452711177373; Wed,
 13 Jan 2016 10:52:57 -0800 (PST)
Received: by 10.36.149.131 with HTTP; Wed, 13 Jan 2016 10:52:38 -0800 (PST)
In-Reply-To: <eca740dbf6271bd69f2ccb14163175996ef7c837.1452270051.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283969>

On Fri, Jan 8, 2016 at 8:21 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Unfortunately, some libgen implementations yield outcomes different from
> what Git expects. For example, mingw-w64-crt provides a basename()
> function, that shortens `path0/` to `path`!
>
> So let's verify that the basename() and dirname() functions we use conform
> to what Git expects.
>
> Derived-from-code-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t0060-path-utils.sh |   3 +
>  test-path-utils.c     | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 171 insertions(+)
>
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 627ef85..f0152a7 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -59,6 +59,9 @@ case $(uname -s) in
>         ;;
>  esac
>
> +test_expect_success basename 'test-path-utils basename'
> +test_expect_success dirname 'test-path-utils dirname'
> +
>  norm_path "" ""
>  norm_path . ""
>  norm_path ./ ""
> diff --git a/test-path-utils.c b/test-path-utils.c
> index c67bf65..74e74c9 100644
> --- a/test-path-utils.c
> +++ b/test-path-utils.c
> @@ -39,6 +39,168 @@ static void normalize_argv_string(const char **var, const char *input)
>                 die("Bad value: %s\n", input);
>  }
>
> +struct test_data {
> +       char *from;  /* input:  transform from this ... */
> +       char *to;    /* output: ... to this.            */
> +};
> +
> +static int test_function(struct test_data *data, char *(*func)(char *input),
> +       const char *funcname)
> +{
> +       int failed = 0, i;
> +       static char buffer[1024];
> +       char *to;
> +
> +       for (i = 0; data[i].to; i++) {
> +               if (!data[i].from)
> +                       to = func(NULL);
> +               else {
> +                       strcpy(buffer, data[i].from);
> +                       to = func(buffer);
> +               }
> +               if (strcmp(to, data[i].to)) {
> +                       error("FAIL: %s(%s) => '%s' != '%s'\n",
> +                               funcname, data[i].from, to, data[i].to);
> +                       failed++;
> +               }
> +       }
> +       return !!failed;
> +}
> +
> +static struct test_data basename_data[] = {
> +       /* --- POSIX type paths --- */
> +       { NULL,              "."    },
> +       { "",                "."    },
> +       { ".",               "."    },
> +       { "..",              ".."   },
> +       { "/",               "/"    },
> +#if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
> +       { "//",              "//"   },
> +       { "///",             "//"   },
> +       { "////",            "//"   },
> +#else
> +       { "//",              "/"    },
> +       { "///",             "/"    },
> +       { "////",            "/"    },
> +#endif
> +       { "usr",             "usr"  },
> +       { "/usr",            "usr"  },
> +       { "/usr/",           "usr"  },
> +       { "/usr//",          "usr"  },
> +       { "/usr/lib",        "lib"  },
> +       { "usr/lib",         "lib"  },
> +       { "usr/lib///",      "lib"  },
> +
> +#if defined(__MINGW32__) || defined(_MSC_VER)
> +
> +       /* --- win32 type paths --- */
> +       { "\\usr",           "usr"  },
> +       { "\\usr\\",         "usr"  },
> +       { "\\usr\\\\",       "usr"  },
> +       { "\\usr\\lib",      "lib"  },
> +       { "usr\\lib",        "lib"  },
> +       { "usr\\lib\\\\\\",  "lib"  },
> +       { "C:/usr",          "usr"  },
> +       { "C:/usr",          "usr"  },
> +       { "C:/usr/",         "usr"  },
> +       { "C:/usr//",        "usr"  },
> +       { "C:/usr/lib",      "lib"  },
> +       { "C:usr/lib",       "lib"  },
> +       { "C:usr/lib///",    "lib"  },
> +       { "C:",              "."    },
> +       { "C:a",             "a"    },
> +       { "C:/",             "/"    },
> +       { "C:///",           "/"    },
> +#if defined(NO_LIBGEN_H)
> +       { "\\",              "\\"   },
> +       { "\\\\",            "\\"   },
> +       { "\\\\\\",          "\\"   },
> +#else
> +
> +       /* win32 platform variations: */
> +#if defined(__MINGW32__)
> +       { "\\",              "/"    },
> +       { "\\\\",            "/"    },
> +       { "\\\\\\",          "/"    },
> +#endif
> +
> +#if defined(_MSC_VER)
> +       { "\\",              "\\"   },
> +       { "\\\\",            "\\"   },
> +       { "\\\\\\",          "\\"   },
> +#endif
> +
> +#endif
> +#endif
> +       { NULL,              "."    },
> +       { NULL,              NULL   }
> +};
> +
> +static struct test_data dirname_data[] = {
> +       /* --- POSIX type paths --- */
> +       { NULL,              "."      },
> +       { "",                "."      },
> +       { ".",               "."      },
> +       { "..",              "."      },
> +       { "/",               "/"      },
> +       { "//",              "//"     },
> +#if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
> +       { "///",             "//"     },
> +       { "////",            "//"     },
> +#else
> +       { "///",             "/"      },
> +       { "////",            "/"      },
> +#endif
> +       { "usr",             "."      },
> +       { "/usr",            "/"      },
> +       { "/usr/",           "/"      },
> +       { "/usr//",          "/"      },
> +       { "/usr/lib",        "/usr"   },
> +       { "usr/lib",         "usr"    },
> +       { "usr/lib///",      "usr"    },
> +
> +#if defined(__MINGW32__) || defined(_MSC_VER)
> +
> +       /* --- win32 type paths --- */
> +       { "\\",              "\\"     },
> +       { "\\\\",            "\\\\"   },
> +       { "\\usr",           "\\"     },
> +       { "\\usr\\",         "\\"     },
> +       { "\\usr\\\\",       "\\"     },
> +       { "\\usr\\lib",      "\\usr"  },
> +       { "usr\\lib",        "usr"    },
> +       { "usr\\lib\\\\\\",  "usr"    },
> +       { "C:a",             "C:."    },
> +       { "C:/",             "C:/"    },
> +       { "C:///",           "C:/"    },
> +       { "C:/usr",          "C:/"    },
> +       { "C:/usr/",         "C:/"    },
> +       { "C:/usr//",        "C:/"    },
> +       { "C:/usr/lib",      "C:/usr" },
> +       { "C:usr/lib",       "C:usr"  },
> +       { "C:usr/lib///",    "C:usr"  },
> +       { "\\\\\\",          "\\"     },
> +       { "\\\\\\\\",        "\\"     },
> +#if defined(NO_LIBGEN_H)
> +       { "C:",              "C:."    },
> +#else
> +
> +       /* win32 platform variations: */
> +#if defined(__MINGW32__)
> +       /* the following is clearly wrong ... */
> +       { "C:",              "."      },
> +#endif
> +
> +#if defined(_MSC_VER)
> +       { "C:",              "C:."    },
> +#endif
> +
> +#endif
> +#endif
> +       { NULL,              "."      },
> +       { NULL,              NULL     }
> +};
> +
>  int main(int argc, char **argv)
>  {
>         if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
> @@ -133,6 +295,12 @@ int main(int argc, char **argv)
>                 return 0;
>         }
>
> +       if (argc == 2 && !strcmp(argv[1], "basename"))
> +               return test_function(basename_data, basename, argv[1]);
> +
> +       if (argc == 2 && !strcmp(argv[1], "dirname"))
> +               return test_function(dirname_data, dirname, argv[1]);
> +
>         fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
>                 argv[1] ? argv[1] : "(there was none)");
>         return 1;
> --
> 2.6.3.windows.1.300.g1c25e49
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Test fails on my Mac:

expecting success: test-path-utils dirname
error: FAIL: dirname(//) => '/' != '//'

not ok 2 - dirname
#    test-path-utils dirname
